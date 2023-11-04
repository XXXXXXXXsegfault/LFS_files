if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/tar-1.34.tar.xz
cd tar-1.34
./configure --prefix=/usr                     \
--host=$LFS_TGT                   \
--build=$(build-aux/config.guess)
make -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf tar-1.34
