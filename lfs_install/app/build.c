#include "copy/build.c"
#include "cpio/build.c"
#include "mkfs.ext2/build.c"
#include "mkfs.ext3/build.c"
#include "mkfs.fat/build.c"
#include "remove/build.c"
#include "installer/build.c"

#include "init/build.c"
#include "install_init/build.c"
void build_apps(void)
{
	build_copy("build/root/bin/copy");
	build_cpio("build/root/bin/cpio");
	build_mkfs_ext2("build/root/bin/mkfs.ext2");
	build_mkfs_ext3("build/root/bin/mkfs.ext3");
	build_mkfs_fat("build/root/bin/mkfs.fat");
	build_remove("build/root/bin/remove");
	build_init("build/root/bin/init");
	build_install_init("build/root/init");
	build_installer("build/root/bin/installer");
}
