if [ ! $LFS_CHROOT ]
then
	exit 1
fi
cd /sources
tar -xf 11.1/iana-etc-20220207.tar.gz
cd iana-etc-20220207
cp services protocols /etc
cd ..
rm -rf iana-etc-20220207
