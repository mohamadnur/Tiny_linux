#!/bin/bash
set -e

# Variables
GCC_VERSION="16.0"
INSTALL_DIR="$HOME/.local/gcc-$GCC_VERSION"
SRC_DIR="$HOME/gcc-src"
BUILD_DIR="$HOME/gcc-build"

echo "🔧 Installing prerequisites..."
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y \
  gcc gcc-c++ git wget tar \
  glibc-devel glibc-devel.i686 \
  libstdc++-devel libstdc++-devel.i686 \
  gmp-devel mpfr-devel libmpc-devel isl-devel \
  zlib-devel

echo "📥 Cloning GCC source code..."
git clone git://gcc.gnu.org/git/gcc.git "$SRC_DIR"
cd "$SRC_DIR"
./contrib/download_prerequisites
cd ..

echo "📁 Creating build directory..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "⚙️ Configuring GCC build..."
"$SRC_DIR/configure" \
  --prefix="$INSTALL_DIR" \
  --enable-languages=c,c++ \
  --disable-multilib \
  --program-suffix="-$GCC_VERSION" \
  --enable-checking=release \
  --enable-threads=posix \
  --enable-shared \
  --enable-__cxa_atexit \
  --with-system-zlib

echo "🧱 Building GCC... this may take a while"
make -j"$(nproc)"

echo "📦 Installing GCC to $INSTALL_DIR"
make install

echo "✅ Done. Add the following to your environment:"
echo
echo "export PATH=\"$INSTALL_DIR/bin:\$PATH\""
echo "export LD_LIBRARY_PATH=\"$INSTALL_DIR/lib64:\$LD_LIBRARY_PATH\""
echo "export CC=\"$INSTALL_DIR/bin/gcc-$GCC_VERSION\""
echo "export CXX=\"$INSTALL_DIR/bin/g++-$GCC_VERSION\""

