#!/usr/bin/env bash
set -Eeuo pipefail

version="$(
	wget -qO- 'https://updates.signal.org/desktop/apt/dists/xenial/main/binary-amd64/Packages.gz' \
		| gunzip \
		| tac|tac \
		| gawk -F ':[[:space:]]+' '
			$1 == "Package" { pkg = $2 }
			$1 == "Version" && pkg == "signal-desktop" { print $2; exit }
		'
)"

echo "signal-desktop: $version"
[ -n "$version" ]

sed -ri \
	-e 's!^(ENV SIGNAL_DESKTOP_VERSION) .*!\1 '"$version"'!' \
	Dockerfile
