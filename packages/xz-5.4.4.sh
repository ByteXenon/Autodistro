install(){
  rm -rf xz-5.4.4
  tar xpfv xz-5.4.4.tar.xz
  cd xz-5.4.4

  ./configure --prefix=/usr                     \
              --host=$LFS_TGT                   \
              --build=$(build-aux/config.guess) \
              --disable-static                  \
              --docdir=/usr/share/doc/xz-5.4.4
  make
  make DESTDIR=$LFS install
  rm -v $LFS/usr/lib/liblzma.la
}