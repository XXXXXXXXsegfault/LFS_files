if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/util-linux-2.37.4.tar.xz
cd util-linux-2.37.4
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime   \
     --bindir=/usr/bin    \
     --libdir=/usr/lib    \
     --sbindir=/usr/sbin  \
     --docdir=/usr/share/doc/util-linux-2.37.4 \
     --disable-chfn-chsh  \
     --disable-login      \
     --disable-nologin    \
     --disable-su         \
     --disable-setpriv    \
     --disable-runuser    \
     --disable-pylibmount \
     --disable-static     \
     --without-python     \
     --without-systemd    \
     --without-systemdsystemunitdir
make -j$CPUS
make install
cd ..
rm -rf util-linux-2.37.4
