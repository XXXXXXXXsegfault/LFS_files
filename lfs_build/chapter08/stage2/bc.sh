if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/bc-5.2.2.tar.xz
cd bc-5.2.2
CC=gcc ./configure --prefix=/usr -G -O3
make -j$CPUS
make install
cd ..
rm -rf bc-5.2.2
