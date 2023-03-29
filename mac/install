#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# To debug, uncomment:
# set -o xtrace

source "../script/lib/utils"

info "Set macOS defaults…"

# General
info "Disable auto-correct"
defaults write -globalDomain "NSAutomaticSpellingCorrectionEnabled" -bool false

info "Disable auto-capitalization"
defaults write -globalDomain "NSAutomaticCapitalizationEnabled" -bool false

info "Disable screensaver"
defaults -currentHost write com.apple.screensaver "idleTime" -int 0

info "Show hidden files in Finder"
defaults write com.apple.finder "AppleShowAllFiles" -bool true && killall Finder

info "Show file extensions in Finder"
defaults write -globalDomain "AppleShowAllExtensions" -bool true

info "Show path bar in Finder"
defaults write com.apple.finder "ShowPathbar" -bool "true"

info "Use column view in Finder"
defaults write com.apple.Finder "FXPreferredViewStyle" clmv

info "Don't show drives on desktop"
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool false
defaults write com.apple.finder "ShowHardDrivesOnDesktop" -bool false

info "Don't rearrange spaces"
defaults write com.apple.dock "mru-spaces" -bool "false"

info "Hide dock"
defaults write com.apple.dock "autohide" -bool true

info "Don't show recent apps in dock"
defaults write com.apple.dock "show-recents" -bool false && killall Dock

info "Set fast key-repeat-rate"
defaults write -globalDomain "InitialKeyRepeat" -int 15
defaults write -globalDomain "KeyRepeat" -int 2

info "Set fast scroll speed"
defaults write -globalDomain "com.apple.mouse.scaling" -int 3
defaults write -globalDomain "com.apple.trackpad.scaling" -int 3

info "Enable tab to click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad "Clicking" -bool true
defaults -currentHost write -globalDomain "com.apple.mouse.tapBehavior" -int 1
