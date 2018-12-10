#!/usr/bin/env bash
set -ex
cd $(dirname "$0")

ORG_PATH="github.com/containernetworking"
export REPO_PATH="${ORG_PATH}/plugins"

export GOPATH=$(mktemp -d -t cni)
mkdir -p ${GOPATH}/src/${ORG_PATH}
trap "{ rm -rf $GOPATH; }" EXIT
ln -s ${PWD} ${GOPATH}/src/${REPO_PATH} || exit 255

export GO="${GO:-go}"
export GOOS=windows

PLUGINS=$(cat plugins/windows_only.txt)
for d in $PLUGINS; do
  if [ -d "$d" ]; then
    plugin="$(basename "$d").exe"
    echo "  $plugin"
    $GO build -o "${PWD}/bin/$plugin" "$@" "$REPO_PATH"/$d
  fi
done
