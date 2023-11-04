if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf libtasn1-4.18.0.tar.gz
cd libtasn1-4.18.0
./configure --prefix=/usr --disable-static
make -j$CPUS
make install
cd ..
rm -rf libtasn1-4.18.0
