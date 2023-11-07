install(){
  rm -rf make-4.4.1
  tar xpfv make-4.4.1.tar.gz
  cd make-4.4.1

  ./configure --prefix=/usr   \
              --without-guile \
              --host=$LFS_TGT \
              --build=$(build-aux/config.guess)
  make
  make DESTDIR=$LFS install
}