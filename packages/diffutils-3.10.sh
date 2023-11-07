install() {
  rm -rf diffutils-3.10
  tar xpfv diffutils-3.10.tar.xz
  cd diffutils-3.10

  
  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(./build-aux/config.guess)
  make
  make DESTDIR=$LFS install
}