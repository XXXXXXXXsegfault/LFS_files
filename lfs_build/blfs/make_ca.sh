if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf make-ca-1.10.tar.xz
cd make-ca-1.10
make install &&
install -vdm755 /etc/ssl/local
cd ..
rm -rf make-ca-1.10
