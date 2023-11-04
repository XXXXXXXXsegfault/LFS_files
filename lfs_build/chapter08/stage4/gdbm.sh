if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/gdbm-1.23.tar.gz
cd gdbm-1.23
./configure --prefix=/usr    \
     --disable-static \
     --enable-libgdbm-compat
make -j$CPUS
make install
cd ..
rm -rf gdbm-1.23
