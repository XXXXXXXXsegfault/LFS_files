if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/acl-2.3.1.tar.xz
cd acl-2.3.1
./configure --prefix=/usr         \
     --disable-static      \
     --docdir=/usr/share/doc/acl-2.3.1
make -j$CPUS
make install
cd ..
rm -rf acl-2.3.1
