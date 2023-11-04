if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/make-4.3.tar.gz
cd make-4.3
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf make-4.3
