if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter09/bootscripts.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter09/config.sh
