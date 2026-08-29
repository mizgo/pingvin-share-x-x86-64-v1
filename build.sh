#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"

if [[ -z "$VERSION" ]]; then
    echo "Usage: $0 <pingvin-version>"
    echo "Example: $0 v1.22.1"
    exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BUILD_ROOT="$REPO_ROOT/.build"
SOURCE_DIR="$BUILD_ROOT/source"
ARCHIVE="$BUILD_ROOT/pingvin-share-x-${VERSION}.tar.gz"

IMAGE="pingvin-share-x-x86-64-v1:${VERSION}"

echo "==> Pingvin Share X: ${VERSION}"
echo "==> Build directory: ${BUILD_ROOT}"
echo "==> Image: ${IMAGE}"
echo

rm -rf "$SOURCE_DIR"
mkdir -p "$SOURCE_DIR"

echo "==> Downloading upstream source..."
curl -fL \
    "https://github.com/smp46/pingvin-share-x/archive/refs/tags/${VERSION}.tar.gz" \
    -o "$ARCHIVE"

echo "==> Extracting source..."
tar -xzf "$ARCHIVE" \
    -C "$SOURCE_DIR" \
    --strip-components=1

echo "==> Applying x86-64-v1 patch..."
python3 "$REPO_ROOT/apply-x86-64-v1-patch.py" "$SOURCE_DIR/Dockerfile"

echo "==> Building Docker image..."
cd "$SOURCE_DIR"

docker build \
    --platform linux/amd64 \
    -t "$IMAGE" \
    .

echo
echo "==> Build completed successfully:"
echo "    $IMAGE"