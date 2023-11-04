if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/grep-3.7.tar.xz
cd grep-3.7
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf grep-3.7
