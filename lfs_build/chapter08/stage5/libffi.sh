if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/libffi-3.4.2.tar.gz
cd libffi-3.4.2
./configure --prefix=/usr          \
     --disable-static       \
     --with-gcc-arch=x86-64 \
     --disable-exec-static-tramp
make -j$CPUS
make install
cd ..
rm -rf libffi-3.4.2
