install(){
  rm -rf patch-2.7.6
  tar xpfv patch-2.7.6.tar.xz
  cd patch-2.7.6

  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(build-aux/config.guess)
  make
  make DESTDIR=$LFS install
}