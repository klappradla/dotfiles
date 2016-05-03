#!/usr/local/bin/zsh

readonly LOG_FILE=~/dotfiles/scripts/log/transfer.log
readonly EXCLUDE_LIST=~/dotfiles/scripts/rsync-excludes.txt
readonly REMOTE=max@HerrDirektor.local

print_to_log() {
  local txt=$1
  echo "$1" >> $LOG_FILE
}

print_info() {
  print_to_log "\nTransfer files to HerrDirektor: $(date +%Y_%m_%d_%H:%M:%S)"
}

sync_files() {
  local src=$1
  local dest=$2

  print_to_log "Transfer $src..."

  rsync -av --delete --exclude-from $EXCLUDE_LIST \
    "$src" -e ssh "$REMOTE":"$dest" >> $LOG_FILE
}

calculate_log_size() {
  ( wc $LOG_FILE | awk '{ print $1 }' )
}

log_too_big() {
  local size=$1
  local max_size=6000
  [ $size -ge $max_size ]
}

truncate_log() {
  local size=$1
  local min_size=300
  local cut=$(($size-$min_size))

  sed -i '' "1,$cut d" $LOG_FILE
}

main() {
  local log_size

  print_info
  sync_files ~/Code ~

  log_size=$(calculate_log_size)
  log_too_big $log_size \
    && truncate_log $log_size
}
main