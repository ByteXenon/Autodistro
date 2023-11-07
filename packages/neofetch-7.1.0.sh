install() {
  local directory="neofetch-7.1.0"
  local file="${directory}.tar.gz"
  rm -rf "$file"

  wget https://github.com/dylanaraps/neofetch/archive/refs/tags/7.1.0.tar.gz -O "$file"

  local expected_md5="37ba9026fdd353f66d822fdce16420a8"
  local actual_md5=$(md5sum "$file" | cut -d ' ' -f 1)
  if [[ "$actual_md5" != "$expected_md5" ]]; then
    echo "Error: MD5 checksum verification failed. Expected $expected_md5, but got $actual_md5."
    exit 1
  fi

  tar xpfv $file
  cd $directory

  make install DESTDIR=$LFS
}
