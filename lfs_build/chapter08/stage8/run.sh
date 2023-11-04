if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage8/sysklogd.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage8/sysvinit.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage8/cleanup.sh
