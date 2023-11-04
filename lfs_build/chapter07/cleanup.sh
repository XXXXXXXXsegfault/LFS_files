if [ ! $LFS_CHROOT ]
then
	exit 1
fi
rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete
rm -rf /tools

