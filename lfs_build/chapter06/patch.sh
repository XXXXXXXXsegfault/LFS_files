if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/patch-2.7.6.tar.xz
cd patch-2.7.6
./configure --prefix=/usr   \
--host=$LFS_TGT \
--build=$(build-aux/config.guess)
make -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf patch-2.7.6
