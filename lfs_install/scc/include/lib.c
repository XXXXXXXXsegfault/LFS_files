asm ".entry"
asm "lea 8(%rsp),%rax"
asm "push %rax"
asm "pushq 8(%rsp)"
asm "call @main"
asm "mov %rax,%rdi"
asm "mov $231,%eax"
asm "syscall"

#define ARCH_BAD_INST asm ".long 0xffffffff"
#include "syscall.c"
#include "mem.c"
#include "malloc.c"
#include "xmalloc.c"
#include "string.c"