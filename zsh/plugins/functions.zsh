allowcmd() {
  local cmd_path=$commands[$1]
  if [[ -z $cmd_path ]]; then
    echo "allowcmd: '$1' not found in PATH" >&2
    return 1
  fi
  xattr -d com.apple.quarantine "$cmd_path"
}

allowapp() {
  xattr -d com.apple.quarantine "/Applications/$1.app"
}
