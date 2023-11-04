#include "../include/build.c"
void build_installer2(char *dst)
{
	cc("install/main.c","build/tmp/tmp.asm");
	assemble("build/tmp/tmp.asm",dst);
}
