if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/texinfo-6.8.tar.xz
cd texinfo-6.8
./configure --prefix=/usr
sed -e 's/__attribute_nonnull__/__nonnull/' \
-i gnulib/lib/malloc/dynarray-skeleton.c
make -j$CPUS
make install
make TEXMF=/usr/share/texmf install-tex
cd ..
rm -rf texinfo-6.8
