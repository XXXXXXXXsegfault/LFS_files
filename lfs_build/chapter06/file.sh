if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/file-5.41.tar.gz
cd file-5.41
mkdir build
pushd build
../configure --disable-bzlib  \
--disable-libseccomp \
--disable-xzlib      \
--disable-zlib
make -j$CPUS
popd
./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)
make FILE_COMPILE=$(pwd)/build/src/file -j$CPUS
make DESTDIR=$LFS install
cd ..
rm -rf file-5.41
