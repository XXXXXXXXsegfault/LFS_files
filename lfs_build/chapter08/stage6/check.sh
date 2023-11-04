if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/check-0.15.2.tar.gz
cd check-0.15.2
./configure --prefix=/usr --disable-static
make -j$CPUS
make docdir=/usr/share/doc/check-0.15.2 install
cd ..
rm -rf check-0.15.2
