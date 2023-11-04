if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/make.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/patch.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/tar.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/texinfo.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/vim.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/eudev.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/mandb.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/procps_ng.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/util_linux.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage7/e2fsprogs.sh
