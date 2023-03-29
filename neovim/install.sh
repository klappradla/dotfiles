#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# To debug, uncomment:
# set -o xtrace

source "../script/lib/utils"

readonly VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
readonly VIM_PLUG_PATH="$HOME/.local/share/nvim/site/autoload/plug.vim"

if [ ! -f "$VIM_PLUG_PATH" ]; then
  info "Install vim-plug…"
  curl -fLo \
    "$VIM_PLUG_PATH" \
    --create-dirs \
    "$VIM_PLUG_URL"
fi

info "Install neovim python support…"
pip3 install --user neovim
