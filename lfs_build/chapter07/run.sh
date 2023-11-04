if [ ! $LFS ]
then
	exit 1
fi
mkdir -pv $LFS/{dev,proc,sys,run}
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/create_files.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/libstdcxx.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/gettext.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/bison.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/perl.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/python.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/texinfo.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/util_linux.sh
LFS=$LFS $LFS/../chroot_run.sh $LFS/../chapter07/cleanup.sh
