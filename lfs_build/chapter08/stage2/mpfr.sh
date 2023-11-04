if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/mpfr-4.1.0.tar.xz
cd mpfr-4.1.0
./configure --prefix=/usr        \
     --disable-static     \
     --enable-thread-safe \
     --docdir=/usr/share/doc/mpfr-4.1.0
make -j$CPUS
make html
make install
make install-html
cd ..
rm -rf mpfr-4.1.0
