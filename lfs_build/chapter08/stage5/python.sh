if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/Python-3.10.2.tar.xz
cd Python-3.10.2
./configure --prefix=/usr        \
     --enable-shared      \
     --with-system-expat  \
     --with-system-ffi    \
     --with-ensurepip=yes \
     --enable-optimizations
make -j$CPUS
make install
install -v -dm755 /usr/share/doc/python-3.10.2/html
tar --strip-components=1  \
--no-same-owner       \
--no-same-permissions \
-C /usr/share/doc/python-3.10.2/html \
-xvf ../11.1/python-3.10.2-docs-html.tar.bz2
cd ..
rm -rf Python-3.10.2
