if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/zlib-1.2.11.tar.xz
cd zlib-1.2.11
./configure --prefix=/usr
make -j$CPUS
make install
rm -fv /usr/lib/libz.a
cd ..
rm -rf zlib-1.2.11
