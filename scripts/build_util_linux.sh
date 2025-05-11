#!/bin/bash
set -e

# Set the root install path
MINI=${MINI:-"$HOME/Tiny_linux/root"}

REPO="https://github.com/util-linux/util-linux"
SRC_DIR="util-linux"
BUILD_DIR="util-build"

echo "📥 Cloning util-linux..."
git clone --depth 1 "$REPO" "$SRC_DIR"

echo "🔧 Running autogen.sh..."
cd "$SRC_DIR"
./autogen.sh
cd ..

echo "🏗️ Preparing build directory..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "⚙️ Configuring util-linux..."
../"$SRC_DIR"/configure --disable-liblastlog2 --prefix=/usr

echo "🛠️ Building util-linux..."
make -j"$(nproc)"

echo "💾 Installing into $MINI..."
make DESTDIR="$MINI" install

echo "✅ util-linux built and installed successfully."

