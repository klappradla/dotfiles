#!/bin/bash

set -e

export PATH="/usr/local/bin:$PATH"
readonly WORKING_DIR="$(dirname "${BASH_SOURCE[0]}")"

source "$WORKING_DIR/backup.conf"

readonly EXCLUDE_LIST="$WORKING_DIR/rsync-excludes.txt"
readonly SOURCE_DIRS=(~/Code ~/Nextcloud)
readonly NAS=$NAS_ADDRESS
readonly BACKUP_VOLUME="$NET_BACKUP/$(hostname -s)/daily/$(date +'%A')"
readonly TODAY="$(date +'%F')"
readonly LAST_RUN_FILE="$WORKING_DIR/.last_backup.txt"
readonly CIPHERS=chacha20-poly1305@openssh.com,aes128-gcm@openssh.com

backup_ran() {
  [ -e $LAST_RUN_FILE ] &&
    grep -Fxq "$TODAY" "$LAST_RUN_FILE"
}

menu_bar() {
  local color=$1
  echo -n "$color" | nc -4u -w0 localhost 1738
}

set_status() {
  local last_status=$?
  if [ "$last_status" -eq "0" ]
  then
    menu_bar green
  else
    menu_bar red
  fi
}

remote_backup() {
  nas_available &&
  sync_files &&
  write_log
}

# NOTE: ssh options:
# T                -> no pseudo tty (less CPU load on destination)
# o Compression=no -> no compression (faster)
# c <ciphers>      -> use a weaker, but faster openssl cipher
# Rsync option: would like to include --xattrs (but does not work)
sync_files() {
  menu_bar orange
  rsync --archive --verbose --executability --delete --exclude-from $EXCLUDE_LIST \
    -e "ssh -T -c $CIPHERS -o Compression=no -x"\
    "${SOURCE_DIRS[@]}" max@"$NAS":"$BACKUP_VOLUME"
}

write_log() {
  echo "$TODAY" | ssh max@$NAS "cat > $BACKUP_VOLUME/last_run.txt"
  echo "$TODAY" > "$LAST_RUN_FILE"
}

nas_available() {
  nc -z "$NAS" 22 > /dev/null
}

main() {
  backup_ran || remote_backup
  set_status
}

main