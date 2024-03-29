if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/expect5.45.4.tar.gz
cd expect5.45.4
./configure --prefix=/usr           \
     --with-tcl=/usr/lib     \
     --enable-shared         \
     --mandir=/usr/share/man \
     --with-tclinclude=/usr/include
make -j$CPUS
make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib
cd ..
rm -rf expect5.45.4
