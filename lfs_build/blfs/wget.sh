if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf wget-1.21.2.tar.gz
cd wget-1.21.2
./configure --prefix=/usr      \
     --sysconfdir=/etc  \
     --with-ssl=openssl &&
make -j$CPUS
make install
cd ..
rm -rf wget-1.21.2
