if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/bash-5.1.16.tar.gz
cd bash-5.1.16
./configure --prefix=/usr                      \
     --docdir=/usr/share/doc/bash-5.1.16 \
     --without-bash-malloc              \
     --with-installed-readline
make -j$CPUS
make install
cd ..
rm -rf bash-5.1.16
