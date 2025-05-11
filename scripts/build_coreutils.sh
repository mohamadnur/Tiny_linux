#!/bin/bash
set -e

# Define install root
MINI=${MINI:-"$HOME/Tiny_linux/root"}

# Define versions and paths
COREUTILS_REPO="https://github.com/coreutils/coreutils"
COREUTILS_DIR="coreutils"
BUILD_DIR="coreutils-build"

echo "🔧 Cloning Coreutils repository..."
git clone --depth 1 "$COREUTILS_REPO" "$COREUTILS_DIR"

echo "📦 Fixing gnulib submodule issue..."
cd "$COREUTILS_DIR"
rm -rf gnulib .git/modules/gnulib || true
git submodule update --init --recursive || {
    git config submodule.gnulib.url https://github.com/coreutils/gnulib.git
    git submodule sync
    git submodule update --init --recursive
}
echo "🚀 Bootstrapping source..."
./bootstrap
cd ..

echo "🏗️ Creating build directory..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "⚙️ Configuring the build..."
../"$COREUTILS_DIR"/configure --without-selinux --disable-libcap --prefix=/usr

echo "🛠️ Building Coreutils..."
make -j"$(nproc)"

echo "📦 Installing into $MINI..."
make DESTDIR="$MINI" install

echo "✅ Coreutils successfully built and installed into $MINI"

