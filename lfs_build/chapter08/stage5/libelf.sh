if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/elfutils-0.186.tar.bz2
cd elfutils-0.186
./configure --prefix=/usr                \
     --disable-debuginfod         \
     --enable-libdebuginfod=dummy
make -j$CPUS
make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a
cd ..
rm -rf elfutils-0.186
