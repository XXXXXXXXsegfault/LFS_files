if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/sed-4.8.tar.xz
cd sed-4.8
./configure --prefix=/usr   \
--host=$LFS_TGT
make -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf sed-4.8
