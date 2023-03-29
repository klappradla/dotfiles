#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# To debug, uncomment:
# set -o xtrace

source "../script/lib//utils.sh"

declare ASDF_BIN="$HOME/.asdf"
readonly VERSION="v0.11.3"

function add_plugin() {
  local name="$1"
  if ! asdf plugin-list | grep -Fq "$name"; then
    asdf plugin-add "$name"
  fi
}

if [ ! -d "$ASDF_BIN" ]; then
  info "Install asdf from github…"
  git clone \
    "https://github.com/asdf-vm/asdf.git" \
    "$ASDF_BIN" \
    --branch "$VERSION"
else
  info "Already installed"
fi

# shellcheck source=../../.asdf/asdf.sh
source "$ASDF_BIN/asdf.sh"

info "Update asdf…"
asdf update

add_plugin "ruby"
add_plugin "nodejs"
add_plugin "erlang"
add_plugin "elixir"

info "Update asdf plugins…"
asdf plugin-update --all
