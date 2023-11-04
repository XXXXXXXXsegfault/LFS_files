#include "../../include/build.c"
void build_mkfs_ext3(char *dst)
{
	cc("app/mkfs.ext3/main.c","build/tmp/tmp.asm");
	assemble("build/tmp/tmp.asm",dst);
}
