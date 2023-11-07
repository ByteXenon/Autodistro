install() {
  rm -rf grep-3.11
  tar xpfv grep-3.11.tar.xz
  cd grep-3.11

  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(./build-aux/config.guess)
  make
  make DESTDIR=$LFS install
}