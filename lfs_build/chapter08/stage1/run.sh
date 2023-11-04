if [ ! $LFS ]
then
	exit 1
fi
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/man_pages.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/iana_etc.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/glibc.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/zlib.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/bzip2.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/xz.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/zstd.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/file.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/readline.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter08/stage1/m4.sh
