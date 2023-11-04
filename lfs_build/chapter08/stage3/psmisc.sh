if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/psmisc-23.4.tar.xz
cd psmisc-23.4
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf psmisc-23.4
