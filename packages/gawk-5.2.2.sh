install() {
  rm -rf gawk-5.2.2
  tar xpfv gawk-5.2.2.tar.xz
  cd gawk-5.2.2

  sed -i 's/extras//' Makefile.in
  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(build-aux/config.guess)
  make
  make DESTDIR=$LFS install
}