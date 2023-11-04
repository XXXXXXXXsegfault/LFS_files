if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/openssl-3.0.1.tar.gz
cd openssl-3.0.1
./config --prefix=/usr         \
  --openssldir=/etc/ssl \
  --libdir=lib          \
  shared                \
  zlib-dynamic
make -j$CPUS
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install
mv -v /usr/share/doc/openssl /usr/share/doc/openssl-3.0.1
cp -vfr doc/* /usr/share/doc/openssl-3.0.1
cd ..
rm -rf openssl-3.0.1
