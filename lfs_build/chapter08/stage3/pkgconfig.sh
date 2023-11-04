if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/pkg-config-0.29.2.tar.gz
cd pkg-config-0.29.2
./configure --prefix=/usr              \
     --with-internal-glib       \
     --disable-host-tool        \
     --docdir=/usr/share/doc/pkg-config-0.29.2
make -j$CPUS
make install
cd ..
rm -rf pkg-config-0.29.2
