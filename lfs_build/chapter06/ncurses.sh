if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/ncurses-6.3.tar.gz
cd ncurses-6.3
sed -i s/mawk// configure
mkdir build
pushd build
../configure
make -C include -j$CPUS
make -C progs tic -j$CPUS
popd
./configure --prefix=/usr    \
--host=$LFS_TGT              \
--build=$(./config.guess)    \
--mandir=/usr/share/man      \
--with-manpage-format=normal \
--with-shared                \
--without-debug              \
--without-ada                \
--without-normal             \
--disable-stripping          \
--enable-widec
make -j$CPUS
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
cd ..
rm -rf ncurses-6.3
