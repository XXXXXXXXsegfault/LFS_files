if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/inetutils-2.2.tar.xz
cd inetutils-2.2
./configure --prefix=/usr        \
     --bindir=/usr/bin    \
     --localstatedir=/var \
     --disable-logger     \
     --disable-whois      \
     --disable-rcp        \
     --disable-rexec      \
     --disable-rlogin     \
     --disable-rsh        \
     --disable-servers
make -j$CPUS
make install
mv -v /usr/{,s}bin/ifconfig
cd ..
rm -rf inetutils-2.2
