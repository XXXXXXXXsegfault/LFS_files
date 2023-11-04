if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/texinfo-6.8.tar.xz
cd texinfo-6.8
sed -e 's/__attribute_nonnull__/__nonnull/' \
-i gnulib/lib/malloc/dynarray-skeleton.c
./configure --prefix=/usr
make -j$CPUS
make install
cd ..
rm -rf texinfo-6.8
