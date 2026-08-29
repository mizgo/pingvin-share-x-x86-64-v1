#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"

if [[ -z "$VERSION" ]]; then
    echo "Usage: $0 <pingvin-version>"
    echo "Example: $0 v1.22.1"
    exit 1
fi

WORKDIR="$(pwd)"
BUILD_DIR="$WORKDIR/build"
SOURCE_DIR="$BUILD_DIR/source"
ARCHIVE="$BUILD_DIR/pingvin-share-x-${VERSION}.tar.gz"

IMAGE="pingvin-share-x-x86-64-v1:${VERSION}-x86-64-v1"

rm -rf "$BUILD_DIR"
mkdir -p "$SOURCE_DIR"

echo "==> Downloading Pingvin Share X ${VERSION}"

curl -L \
    "https://github.com/smp46/pingvin-share-x/archive/refs/tags/${VERSION}.tar.gz" \
    -o "$ARCHIVE"

echo "==> Extracting source"

tar -xzf "$ARCHIVE" \
    -C "$SOURCE_DIR" \
    --strip-components=1

echo "==> Applying x86-64-v1 patch"

python3 apply-x86-64-v1-patch.py

echo "==> Building ${IMAGE}"

cd "$SOURCE_DIR"

docker build \
    --platform linux/amd64 \
    -t "$IMAGE" \
    .

echo
echo "Build completed successfully:"
echo "  $IMAGE"
