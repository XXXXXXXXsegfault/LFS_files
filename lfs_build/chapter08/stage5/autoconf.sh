if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/autoconf-2.71.tar.xz
cd autoconf-2.71
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf autoconf-2.71
