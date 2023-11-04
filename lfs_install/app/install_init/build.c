#include "../../include/build.c"
void build_install_init(char *dst)
{
	cc("app/install_init/main.c","build/tmp/tmp.asm");
	assemble("build/tmp/tmp.asm",dst);
}
