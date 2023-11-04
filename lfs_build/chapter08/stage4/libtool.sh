if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/libtool-2.4.6.tar.xz
cd libtool-2.4.6
./configure --prefix=/usr
make -j$CPUS
make install
rm -fv /usr/lib/libltdl.a
cd ..
rm -rf libtool-2.4.6
