if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/gzip-1.11.tar.xz
cd gzip-1.11
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf gzip-1.11
