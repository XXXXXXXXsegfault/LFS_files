if [ ! $LFS ]
then
	exit 1
fi
cp $LFS/../boot/linux.config $LFS/sources
LFS=$LFS $LFS/../chroot_run.sh $LFS/../boot/kernel.sh
mkdir -p $LFS/usr/src/lfs_build
cp -r $LFS/../{chapter*,*.sh,blfs,boot,SHA256SUM,scripts,lfs_mirrors} $LFS/usr/src/lfs_build
rm -f $LFS/usr/src/lfs_build/scripts/lfswd
rm -f $LFS/usr/src/lfs_build/scripts/domainname
LFS=$LFS $LFS/../chroot_run.sh $LFS/../boot/boot.sh

