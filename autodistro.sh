# Exit on error
set -e

source ./libs/helpers.sh

set_environment_variables() {
  export installer_root="$PWD"
  export LC_ALL=POSIX
  export LFS="$installer_root/install"
  export LFS_TGT=$(uname -m)-lfs-linux-gnu
  export PATH=/usr/bin
  if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
  export PATH=$LFS/tools/bin:$PATH
  export CONFIG_SITE=$LFS/usr/share/config.site
  export MAKEFLAGS="-j16 -l16"
}
create_directories() {
  cd "${LFS}"

  # Make root lfs directory
  mkdir --parents "${LFS}"

  # Make /lfs/sources directory
  mkdir --parents "${LFS}/sources"
  chmod a+wt "${LFS}/sources"
  chown root:root $LFS/sources/*

  # Make required directories
  mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

  for i in bin lib sbin; do
    ln -sv usr/$i $LFS/$i
  done
  case $(uname -m) in
    x86_64) mkdir -pv $LFS/lib64 ;;
  esac

  mkdir -pv $LFS/tools
}
install_sources(){
  # Install required files
  wget --input-file="${installer_root}/data/wget-list-sysv" --no-clobber --continue --directory-prefix="${LFS}/sources" 2>/dev/null
  check_files_in_directory "${installer_root}/data/filenames" "${LFS}/sources"
}
compile_packages(){
  packages=(
    "binutils-2.41-1.sh"
    "gcc-13.2.0-1.sh"
    "linux-6.4.12.sh"
    "glibc-2.38.sh"
    "libstdc++-v3.sh"
    "m4-1.4.19.sh"
    "ncurses-6.4.sh"
    "bash-5.2.15.sh"
    "coreutils-9.3.sh"
    "diffutils-3.10.sh"
    "file-5.45.sh"
    "findutils-4.9.0.sh"
    "gawk-5.2.2.sh"
    "grep-3.11.sh"
    "gzip-1.12.sh"
    "make-4.4.1.sh"
    "patch-2.7.6.sh"
    "sed-4.9.sh"
    "tar-1.35.sh"
    "xz-5.4.4.sh"
    "binutils-2.41-2.sh"
    "gcc-13.2.0-2.sh"
    "neofetch-7.1.0.sh"
  )

  for package in "${packages[@]}"; do
    echo "Installing ${package}"
    cd "${LFS}/sources";
    source "${installer_root}/packages/${package}";
    install 1>/dev/null;
    echo "Installed ${package}";
  done
}
prepare_chroot() {
  chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools}
  case $(uname -m) in
    x86_64) chown -R root:root $LFS/lib64 ;;
  esac

  mkdir -pv $LFS/{dev,proc,sys,run}

  mount -v --bind /dev/pts $LFS/dev/pts 2>/dev/null || /bin/true
  mount -vt proc proc $LFS/proc
  mount -vt sysfs sysfs $LFS/sys
  mount -vt tmpfs tmpfs $LFS/run

  # I couldn't care less about these stupid non-existent directories, honestly
  if [ -h $LFS/dev/shm ]; then
    mkdir -pv $LFS/$(readlink $LFS/dev/shm) 2>/dev/null || /bin/true
  else
    mount -t tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm 2>/dev/null || /bin/true
  fi
}
enter_chroot() {
  chroot "$LFS" /usr/bin/env -i   \
      HOME=/root                  \
      TERM="$TERM"                \
      PS1='(lfs chroot) \u:\w\$ ' \
      PATH=/usr/bin:/usr/sbin     \
      /bin/bash --login
}

main(){
  set_environment_variables
  create_directories
  install_sources
  compile_packages
  prepare_chroot
  enter_chroot
}

main