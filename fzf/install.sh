#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# To debug, uncomment:
# set -o xtrace

source "../script/lib/utils.sh"

brew install fzf

info "INSTALL FZF KEY BINDINGS AND COMPLETION…"
$(brew --prefix)/opt/fzf/install --no-update-rc


