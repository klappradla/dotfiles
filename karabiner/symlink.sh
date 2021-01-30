#!/bin/bash

set -e

source "../script/lib/utils.sh"

readonly TOPIC_DIR=$(pwd)
# NOTE: necessary for having absolute paths
readonly SYMLINKS=$(find "$TOPIC_DIR" -maxdepth 1 -name "*.symlink")

for src in $SYMLINKS; do
  name=$(basename "$src" .symlink)
  dest="$HOME/.config/$name"
  symlink "$src" "$dest"
done
