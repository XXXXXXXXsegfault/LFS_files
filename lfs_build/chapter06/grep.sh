if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/grep-3.7.tar.xz
cd grep-3.7
./configure --prefix=/usr   \
--host=$LFS_TGT
make -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf grep-3.7
