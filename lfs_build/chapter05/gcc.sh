if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/gcc-11.2.0.tar.xz
cd gcc-11.2.0
tar -xf ../11.1/mpfr-4.1.0.tar.xz
mv -v mpfr-4.1.0 mpfr
tar -xf ../11.1/gmp-6.2.1.tar.xz
mv -v gmp-6.2.1 gmp
tar -xf ../11.1/mpc-1.2.1.tar.gz
mv -v mpc-1.2.1 mpc
sed -e '/m64=/s/lib64/lib/' \
-i.orig gcc/config/i386/t-linux64
mkdir -v build
cd       build
../configure                  \
--target=$LFS_TGT         \
--prefix=$LFS/tools       \
--with-glibc-version=2.35 \
--with-sysroot=$LFS       \
--with-newlib             \
--without-headers         \
--enable-initfini-array   \
--disable-nls             \
--disable-shared          \
--disable-multilib        \
--disable-decimal-float   \
--disable-threads         \
--disable-libatomic       \
--disable-libgomp         \
--disable-libquadmath     \
--disable-libssp          \
--disable-libvtv          \
--disable-libstdcxx       \
--enable-languages=c,c++
make -j$CPUS
make install
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
`dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
cd ..
rm -rf gcc-11.2.0
