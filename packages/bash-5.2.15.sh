install() {
  rm -rf bash-5.2.15
  tar xpfv bash-5.2.15.tar.gz
  cd bash-5.2.15

  ./configure --prefix=/usr                      \
              --build=$(sh support/config.guess) \
              --host=$LFS_TGT                    \
              --without-bash-malloc
  make
  make DESTDIR=$LFS install
  ln -sv bash $LFS/bin/sh
}