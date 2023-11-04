if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/binutils-2.38.tar.xz
cd binutils-2.38
mkdir -v build
cd       build
../configure --prefix=$LFS/tools \
      --with-sysroot=$LFS \
      --target=$LFS_TGT   \
      --disable-nls       \
      --disable-werror
make -j$CPUS
make install
cd ../..
rm -rf binutils-2.38
