if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/attr-2.5.1.tar.gz
cd attr-2.5.1
./configure --prefix=/usr     \
     --disable-static  \
     --sysconfdir=/etc \
     --docdir=/usr/share/doc/attr-2.5.1
make -j$CPUS
make install
cd ..
rm -rf attr-2.5.1
