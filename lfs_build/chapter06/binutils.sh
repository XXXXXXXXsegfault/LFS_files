if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/binutils-2.38.tar.xz
cd binutils-2.38
sed '6009s/$add_dir//' -i ltmain.sh
mkdir -v build
cd       build
../configure                   \
--prefix=/usr              \
--build=$(../config.guess) \
--host=$LFS_TGT            \
--disable-nls              \
--enable-shared            \
--disable-werror           \
--enable-64-bit-bfd
make -j$CPUS
make DESTDIR=$LFS install
cd ../..
rm -rf binutils-2.38
