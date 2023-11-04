if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/util-linux-2.37.4.tar.xz
cd util-linux-2.37.4
mkdir -pv /var/lib/hwclock
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime    \
     --libdir=/usr/lib    \
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
     runstatedir=/run
make -j$CPUS
make install
cd ..
rm -rf util-linux-2.37.4
