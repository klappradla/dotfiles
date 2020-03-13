#!/bin/bash

set -e

echo $(pwd)
source "./../scripts/utils.sh"

readonly TOPIC_DIR=$(pwd)
# NOTE: necessary for having absolute paths
readonly SYMLINKS=$(find "$TOPIC_DIR" -maxdepth 1 -name "*.symlink")

for src in $SYMLINKS; do
  name=$(basename "$src" .symlink)
  dest="$HOME/.$name"
  symlink "$src" "$dest"
done
