if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/patch-2.7.6.tar.xz
cd patch-2.7.6
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf patch-2.7.6
