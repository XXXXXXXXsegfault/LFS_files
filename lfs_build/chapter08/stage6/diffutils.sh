if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/diffutils-3.8.tar.xz
cd diffutils-3.8
./configure --prefix=/usr
make
make install
cd ..
rm -rf diffutils-3.8
