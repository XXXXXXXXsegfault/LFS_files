if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/bash-5.1.16.tar.gz
cd bash-5.1.16
./configure --prefix=/usr       \
--build=$(support/config.guess) \
--host=$LFS_TGT                 \
--without-bash-malloc
make -j$CPUS
make DESTDIR=$LFS install
ln -sv bash $LFS/bin/sh
cd ..
rm -rf bash-5.1.16
