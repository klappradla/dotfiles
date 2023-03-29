#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# To debug, uncomment:
# set -o xtrace

source "../script/lib/utils"

HOMEBREW_ZSH="$(brew --prefix)/bin/zsh"
readonly HOMEBREW_ZSH

if [ "$SHELL" != "$HOMEBREW_ZSH" ]; then
  info "Set homebew's zsh as default shell"

  if ! grep "$HOMEBREW_ZSH" /etc/shells > /dev/null 2>&1 ; then
    sudo sh -c "echo $HOMEBREW_ZSH >> /etc/shells" 2>&1
  fi
  sudo chsh -s "$HOMEBREW_ZSH" "$USER" 2>&1
fi
