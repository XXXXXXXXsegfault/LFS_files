if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/mpc-1.2.1.tar.gz
cd mpc-1.2.1
./configure --prefix=/usr    \
     --disable-static \
     --docdir=/usr/share/doc/mpc-1.2.1
make -j$CPUS
make html
make install
make install-html
cd ..
rm -rf mpc-1.2.1
