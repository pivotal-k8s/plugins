#!/usr/bin/env bash
#
# Run CNI plugin tests.
#
set -e

source ./build_windows.sh

echo "Running tests"

GINKGO_FLAGS="-p --randomizeAllSpecs --randomizeSuites --failOnPending --progress"

# user has not provided PKG override
if [ -z "$PKG" ]; then
  GINKGO_FLAGS="$GINKGO_FLAGS -r ."
  LINT_TARGETS="./..."

# user has provided PKG override
else
  GINKGO_FLAGS="$GINKGO_FLAGS $PKG"
  LINT_TARGETS="$PKG"
fi

bash -c "umask 0; cd ${GOPATH}/src/${REPO_PATH}; PATH='${GOROOT}/bin:$(pwd)/bin:${PATH}' ginkgo ${GINKGO_FLAGS}"
