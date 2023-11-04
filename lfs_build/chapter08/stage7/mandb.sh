if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/man-db-2.10.1.tar.xz
cd man-db-2.10.1
./configure --prefix=/usr                         \
     --docdir=/usr/share/doc/man-db-2.10.1 \
     --sysconfdir=/etc                     \
     --disable-setuid                      \
     --enable-cache-owner=bin              \
     --with-browser=/usr/bin/lynx          \
     --with-vgrind=/usr/bin/vgrind         \
     --with-grap=/usr/bin/grap             \
     --with-systemdtmpfilesdir=            \
     --with-systemdsystemunitdir=
make -j$CPUS
make install
cd ..
rm -rf man-db-2.10.1
