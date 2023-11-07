install(){
  rm -rf sed-4.9
  tar xpfv sed-4.9.tar.xz
  cd sed-4.9

  ./configure --prefix=/usr   \
              --host=$LFS_TGT \
              --build=$(./build-aux/config.guess)
  make
  make DESTDIR=$LFS install
}