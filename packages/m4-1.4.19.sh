install() {
  rm -rf m4-1.4.19
  tar xpfv m4-1.4.19.tar.xz
  cd m4-1.4.19

  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(build-aux/config.guess)
  make
  make DESTDIR=$LFS install
}