install(){
  rm -rf gzip-1.12
  tar xpfv gzip-1.12.tar.xz
  cd gzip-1.12

  ./configure --prefix=/usr --host=$LFS_TGT
  make
  make DESTDIR=$LFS install
}