if [ ! $LFS ] || [ ! $LFS_TGT ]
then
	exit 1
fi
tar -xf 11.1/linux-5.16.9.tar.xz
cd linux-5.16.9
make mrproper
make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr
cd ..
rm -rf linux-5.16.9
