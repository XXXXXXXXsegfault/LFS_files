if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/flex-2.6.4.tar.gz
cd flex-2.6.4
./configure --prefix=/usr \
--docdir=/usr/share/doc/flex-2.6.4 \
--disable-static
make -j$CPUS
make install
ln -sv flex /usr/bin/lex
cd ..
rm -rf flex-2.6.4
