if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/procps-ng-3.3.17.tar.xz
cd procps-3.3.17
./configure --prefix=/usr                            \
     --docdir=/usr/share/doc/procps-ng-3.3.17 \
     --disable-static                         \
     --disable-kill
make -j$CPUS
make install
cd ..
rm -rf procps-3.3.17
