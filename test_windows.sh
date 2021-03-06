#!/usr/bin/env bash
#
# Run CNI plugin tests.
#
set -e

source ./build_windows.sh

echo "Running tests"

PLUGINS=$(cat plugins/windows_only.txt | tr '\n' ' ')
GINKGO_FLAGS="-p --randomizeAllSpecs --randomizeSuites --failOnPending --progress $PLUGINS"

bash -c "cd ${GOPATH}/src/${REPO_PATH}; PATH='${GOROOT}/bin:$(pwd)/bin:${PATH}' ginkgo ${GINKGO_FLAGS}"
