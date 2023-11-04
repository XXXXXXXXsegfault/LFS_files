if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/file-5.41.tar.gz
cd file-5.41
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf file-5.41
