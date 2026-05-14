#!/usr/bin/env bash
# Link host-specific hypr configs into the names hyprland/hyprpaper read.
# These symlinks are intentionally NOT tracked by yadm so that yadm commands
# don't recreate them and trigger spurious Hyprland reloads.
#
# Run once per host (re-run is idempotent).

set -euo pipefail

host="$(hostname)"
dir="${XDG_CONFIG_HOME:-$HOME/.config}/hypr"

for base in system hyprpaper; do
    target="$dir/${base}-${host}.conf"
    link="$dir/${base}.conf"
    if [[ ! -f "$target" ]]; then
        echo "skip: $target not found" >&2
        continue
    fi
    ln -sfn "$target" "$link"
    echo "linked: $link -> $target"
done
