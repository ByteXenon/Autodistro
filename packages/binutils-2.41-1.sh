install() {
  rm -rf binutils-2.41
  tar xpfv binutils-2.41.tar.xz
  cd binutils-2.41

  mkdir -v build
  cd       build

  ../configure --prefix="${LFS}/tools" \
               --with-sysroot="${LFS}" \
               --target="${LFS_TGT}"   \
               --disable-nls           \
               --enable-gprofng=no     \
               --disable-werror
  make
  make install
}