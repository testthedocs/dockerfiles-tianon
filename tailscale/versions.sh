#!/usr/bin/env bash
set -Eeuo pipefail

[ -e versions.json ]

dir="$(readlink -ve "$BASH_SOURCE")"
dir="$(dirname "$dir")"
source "$dir/../.libs/git.sh"

json="$(git-tags 'https://github.com/tailscale/tailscale.git')"

# TODO verify that the scraped version exists on https://pkgs.tailscale.com/stable/#static

jq <<<"$json" -S 'del(.tag)' > versions.json