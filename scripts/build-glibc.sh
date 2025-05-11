#!/bin/bash
# build-glibc.sh: Build and install glibc using custom GCC

set -e

# === Configuration ===
GLIBC_REPO="git://sourceware.org/git/glibc.git"
GLIBC_SRC="glibc"
GLIBC_BUILD="glibc-build"
INSTALL_PREFIX="/usr"
LIBDIR="/lib"

# === Custom toolchain path ===
export MINI="$HOME/Tiny_linux/root"
export GCC_PATH="$HOME/.local/gcc-16.0"
export PATH="$GCC_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$GCC_PATH/lib64"

# === Optional cleanup ===
rm -rf "$GLIBC_SRC" "$GLIBC_BUILD"

# === Clone source ===
git clone "$GLIBC_REPO" "$GLIBC_SRC"

# === Create build directory ===
mkdir "$GLIBC_BUILD"
cd "$GLIBC_BUILD"

# === Configure ===
"../$GLIBC_SRC/configure" \
  --prefix="$INSTALL_PREFIX" \
  --libdir="$LIBDIR"

# === Compile ===
make -j"$(nproc)"

# === Install ===
make DESTDIR="$MINI" install

echo "✅ glibc built and installed into $MINI"

