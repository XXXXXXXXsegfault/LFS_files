if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/make-4.3.tar.gz
cd make-4.3
./configure --prefix=/usr   \
--without-guile \
--host=$LFS_TGT \
--build=$(build-aux/config.guess)
make -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf make-4.3
