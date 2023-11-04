if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/binutils-2.38.tar.xz
cd binutils-2.38
patch -Np1 -i ../11.1/binutils-2.38-lto_fix-1.patch
sed -e '/R_386_TLS_LE /i \   || (TYPE) == R_386_TLS_IE \\' \
-i ./bfd/elfxx-x86.h
mkdir -v build
cd       build
../configure --prefix=/usr       \
      --enable-gold       \
      --enable-ld=default \
      --enable-plugins    \
      --enable-shared     \
      --disable-werror    \
      --enable-64-bit-bfd \
      --with-system-zlib

make tooldir=/usr -j$CPUS
make tooldir=/usr install
rm -fv /usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes}.a
cd ../..
rm -rf binutils-2.38
