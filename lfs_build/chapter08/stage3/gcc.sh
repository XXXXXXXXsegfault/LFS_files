if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/gcc-11.2.0.tar.xz
cd gcc-11.2.0
sed -e '/static.*SIGSTKSZ/d' \
-e 's/return kAltStackSize/return SIGSTKSZ * 4/' \
-i libsanitizer/sanitizer_common/sanitizer_posix_libcdep.cpp
sed -e '/m64=/s/lib64/lib/' \
 -i.orig gcc/config/i386/t-linux64
mkdir -v build
cd       build
../configure --prefix=/usr            \
      LD=ld                    \
      --enable-languages=c,c++ \
      --disable-multilib       \
      --disable-bootstrap      \
      --with-system-zlib
make -j$CPUS
make install
rm -rf /usr/lib/gcc/$(gcc -dumpmachine)/11.2.0/include-fixed/bits/
ln -svr /usr/bin/cpp /usr/lib
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/11.2.0/liblto_plugin.so \
 /usr/lib/bfd-plugins/
mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib
cd ../..
rm -rf gcc-11.2.0
