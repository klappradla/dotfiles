allowcmd() {
  xattr -d com.apple.quarantine $(which "$1")
}

allowapp() {
  xattr -d com.apple.quarantine "/Applications/$1.app"
}
