if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/xz-5.2.5.tar.xz
cd xz-5.2.5
./configure --prefix=/usr                     \
--host=$LFS_TGT                   \
--build=$(build-aux/config.guess) \
--disable-static                  \
--docdir=/usr/share/doc/xz-5.2.5
make -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf xz-5.2.5
