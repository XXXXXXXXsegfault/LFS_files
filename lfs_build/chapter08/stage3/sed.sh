if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/sed-4.8.tar.xz
cd sed-4.8
./configure --prefix=/usr
make -j$CPUS
make html
make install
install -d -m755           /usr/share/doc/sed-4.8
install -m644 doc/sed.html /usr/share/doc/sed-4.8
cd ..
rm -rf sed-4.8
