#!/bin/bash

LOG_FILE="/var/log/zivpn-expired.log"

function log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

function acquire_users_db_lock() {
    local lock_file="${1:-$USERS_DB_LOCK_FILE}"
    local __lock_fd_var="${2:-USERS_DB_LOCK_FD}"

    exec {lock_fd}>"$lock_file" || return 1
    if ! flock -x "$lock_fd"; then
        eval "exec ${lock_fd}>&-"
        return 1
    fi

    printf -v "$__lock_fd_var" '%s' "$lock_fd"
}

function release_users_db_lock() {
    local lock_fd="$1"

    [ -n "$lock_fd" ] || return 0
    flock -u "$lock_fd" 2>/dev/null || true
    eval "exec ${lock_fd}>&-"
}

function _delete_expired_accounts() {
    local db_file="/etc/zivpn/users.db"
    local config_file="/etc/zivpn/config.json"
    local tmp_config_file="${config_file}.tmp"
    local lock_fd
    local current_date=$(date +%s)
    local expired_accounts=()

    # Cek file
    if [ ! -f "$db_file" ]; then
        log "Database file tidak ditemukan: $db_file"
        return 0
    fi

    # Lock database
    acquire_users_db_lock "${db_file}.lock" lock_fd || {
        log "Gagal lock database"
        return 1
    }

    # Ambil akun expired
    while IFS=':' read -r password expiry_date; do
        [[ -z "$password" ]] && continue

        if [[ "$expiry_date" =~ ^[0-9]+$ ]] && [ "$expiry_date" -le "$current_date" ]; then
            expired_accounts+=("$password")
        fi
    done < "$db_file"

    # Hapus dari DB
    for pass in "${expired_accounts[@]}"; do
        sed -i "/^${pass}:/d" "$db_file"
    done

    release_users_db_lock "$lock_fd"

    # Hapus dari config.json
    if [ -f "$config_file" ]; then
        for pass in "${expired_accounts[@]}"; do
            jq --arg p "$pass" 'del(.auth.config[] | select(. == $p))' "$config_file" > "$tmp_config_file" \
            && mv "$tmp_config_file" "$config_file"
        done
    else
        log "Config file tidak ditemukan: $config_file"
    fi

    # Log hasil
    if [ "${#expired_accounts[@]}" -gt 0 ]; then
        log "Menghapus ${#expired_accounts[@]} akun expired: ${expired_accounts[*]}"
        restart_zivpn
        log "Service zivpn direstart"
    else
        log "Tidak ada akun expired"
    fi
}

_delete_expired_accounts