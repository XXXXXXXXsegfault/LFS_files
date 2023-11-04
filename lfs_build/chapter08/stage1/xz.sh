if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/xz-5.2.5.tar.xz
cd xz-5.2.5
./configure --prefix=/usr    \
     --disable-static \
     --docdir=/usr/share/doc/xz-5.2.5
make
make install
cd ..
rm -rf xz-5.2.5
