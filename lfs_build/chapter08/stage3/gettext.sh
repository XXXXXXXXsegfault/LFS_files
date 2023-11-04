if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/gettext-0.21.tar.xz
cd gettext-0.21
./configure --prefix=/usr    \
     --disable-static \
     --docdir=/usr/share/doc/gettext-0.21
make -j$CPUS
make install
chmod -v 0755 /usr/lib/preloadable_libintl.so
cd ..
rm -rf gettext-0.21
