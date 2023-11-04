if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/eudev-3.2.11.tar.gz
cd eudev-3.2.11
./configure --prefix=/usr           \
     --bindir=/usr/sbin      \
     --sysconfdir=/etc       \
     --enable-manpages       \
     --disable-static
make -j$CPUS
mkdir -pv /usr/lib/udev/rules.d
mkdir -pv /etc/udev/rules.d
make install
tar -xvf ../11.1/udev-lfs-20171102.tar.xz
make -f udev-lfs-20171102/Makefile.lfs install
cd ..
rm -rf eudev-3.2.11
