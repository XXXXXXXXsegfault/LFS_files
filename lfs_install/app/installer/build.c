#include "../../include/build.c"
void build_installer(char *dst)
{
	cc("app/installer/main.c","build/tmp/tmp.asm");
	assemble("build/tmp/tmp.asm",dst);
}
