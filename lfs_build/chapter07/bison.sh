if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/bison-3.8.2.tar.xz
cd bison-3.8.2
./configure --prefix=/usr \
--docdir=/usr/share/doc/bison-3.8.2
make -j$CPUS
make install
cd ..
rm -rf bison-3.8.2
