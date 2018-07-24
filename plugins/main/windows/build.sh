#!/usr/bin/env bash
set -e

if [ "$(go env GOARCH 2>&1)" != "amd64" ]; then
	echo "    skipping on non-amd64 architecture"
	exit 0
fi

OUTDIR="${PWD}/bin/windows"
mkdir -p ${OUTDIR}

PLUGINS="plugins/main/windows/*"
for d in $PLUGINS; do
	if [ -d "$d" ]; then
		plugin="$(basename "$d")"
		echo "     $plugin.exe"
		$GO build -o "${OUTDIR}/$plugin.exe" "$@" "$REPO_PATH"/$d
	fi
done
