if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/Python-3.10.2.tar.xz
cd Python-3.10.2
./configure --prefix=/usr   \
     --enable-shared \
     --without-ensurepip
make -j$CPUS
make install
cd ..
rm -rf Python-3.10.2
