if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/expat-2.4.6.tar.xz
cd expat-2.4.6
./configure --prefix=/usr    \
     --disable-static \
     --docdir=/usr/share/doc/expat-2.4.6
make -j$CPUS
make install
install -v -m644 doc/*.{html,css} /usr/share/doc/expat-2.4.6
cd ..
rm -rf expat-2.4.6
