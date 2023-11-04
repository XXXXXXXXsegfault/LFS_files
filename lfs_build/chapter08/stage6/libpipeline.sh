if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/libpipeline-1.5.5.tar.gz
cd libpipeline-1.5.5
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf libpipeline-1.5.5
