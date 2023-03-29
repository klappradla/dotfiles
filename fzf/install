#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# To debug, uncomment:
# set -o xtrace

source "../script/lib/utils"

brew install fzf

info "Install fzf key bindings and completion…"
$(brew --prefix)/opt/fzf/install --no-update-rc
