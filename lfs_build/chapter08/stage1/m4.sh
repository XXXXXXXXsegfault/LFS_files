if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/m4-1.4.19.tar.xz
cd m4-1.4.19
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf m4-1.4.19
