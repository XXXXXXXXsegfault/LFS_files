if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf dosfstools-4.2.tar.gz
cd dosfstools-4.2
./configure --prefix=/usr            \
     --enable-compat-symlinks \
     --mandir=/usr/share/man  \
     --docdir=/usr/share/doc/dosfstools-4.2 &&
make -j$CPUS
make install
cd ..
rm -rf dosfstools-4.2
