if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/gawk-5.1.1.tar.xz
cd gawk-5.1.1
sed -i 's/extras//' Makefile.in
./configure --prefix=/usr   \
--host=$LFS_TGT \
--build=$(build-aux/config.guess)
make -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf gawk-5.1.1
