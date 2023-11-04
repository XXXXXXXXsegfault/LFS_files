if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/coreutils-9.0.tar.xz
cd coreutils-9.0
patch -Np1 -i ../11.1/coreutils-9.0-i18n-1.patch
patch -Np1 -i ../11.1/coreutils-9.0-chmod_fix-1.patch
autoreconf -fiv
FORCE_UNSAFE_CONFIGURE=1 ./configure \
     --prefix=/usr            \
     --enable-no-install-program=kill,uptime
make -j$CPUS
make install
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/' /usr/share/man/man8/chroot.8
cd ..
rm -rf coreutils-9.0
