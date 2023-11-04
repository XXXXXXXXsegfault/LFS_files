if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/findutils-4.9.0.tar.xz
cd findutils-4.9.0
./configure --prefix=/usr                   \
--localstatedir=/var/lib/locate \
--host=$LFS_TGT                 \
--build=$(build-aux/config.guess)
make -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf findutils-4.9.0
