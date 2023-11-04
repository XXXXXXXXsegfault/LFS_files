if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/less-590.tar.gz
cd less-590
./configure --prefix=/usr --sysconfdir=/etc
make -j$CPUS
make install
cd ..
rm -rf less-590
