if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/gmp-6.2.1.tar.xz
cd gmp-6.2.1
cp -v configfsf.guess config.guess
cp -v configfsf.sub   config.sub
./configure --prefix=/usr    \
     --enable-cxx     \
     --disable-static \
     --build=x86_64-pc-linux-gnu \
     --docdir=/usr/share/doc/gmp-6.2.1
make -j$CPUS
make html
make install
make install-html
cd ..
rm -rf gmp-6.2.1
