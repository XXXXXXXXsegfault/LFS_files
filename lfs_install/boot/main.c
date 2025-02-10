asm "@entry"
asm "lea @startc-@__X(%rip),%rax"
asm "@__X"
asm "push %rdx"
asm "push %rcx"
asm "cmp $@startc,%rax"
asm "jne @relocate_code"
asm "@__Y"
asm "pushq $0x100000"
asm "pushq $0"
asm "pushq $0x100000"
asm "call @memset"
asm "add $24,%rsp"
asm "call @main"
asm "add $16,%rsp"
asm "ret"
asm "@relocate_code"
asm "mov %rax,%r8"
asm "pushq $@_memmove_end-@_memmove_start"
asm "lea @_memmove_start-@startc(%rax),%rcx"
asm "push %rcx"
asm "pushq $0x1000000"
asm "call @memmove"
asm "add $24,%rsp"
asm "pushq $@end_code-@startc"
asm "push %r8"
asm "pushq $@startc"
asm "pushq $@__Y1"
asm "mov $0x1000000+@memmove-@_memmove_start,%rcx"
asm "jmp *%rcx"
asm "@__Y1"
asm "add $24,%rsp"
asm "jmp @__Y"

#include "../include/mem.c"
#include "efi.c"
struct EFI_system_table *efitab;
void *efihandle;
void bootid(void); // filled by build.c
#include "palloc.c"
#include "graphics.c"
#include "../include/font.c"
unsigned int getch(void)
{
	unsigned int code;
	code=0xffffffff;
	efipush(efitab->conin);
	efipush(&code);
	eficall(efitab->conin->read_key);
	return code;
}
void error_message(char *str)
{
	memset(video_buf,0,fbheight*fblength*4);
	p_str("Error:",6,0,0,0xffffff,video_buf,fblength,fbheight);
	p_str(str,strlen(str),56,0,0xffffff,video_buf,fblength,fbheight);
	p_str("Please press any key to exit.",29,0,16,0xffffff,video_buf,fblength,fbheight);
	memcpy(fbstart,video_buf,fbheight*fblength*4);
	while(getch()==0xffffffff);
}
#include "block.c"
#include "../include/ext2.c"
#include "ext2_load.c"
#include "do_boot.c"
struct ext2_image config;
int max_configs;
int config_y;
int config_next_line(int i)
{
	while(i<config.size)
	{
		if(config.data[i]=='\n')
		{
			++i;
			break;
		}
		++i;
	}
	return i;
}
void p_entries(void)
{
	int y,i,x;
	unsigned int color;
	memset(video_buf,0,fbheight*fblength*4);
	y=0;
	i=0;
	while(y<max_configs&&i<config.size)
	{
		while(i<config.size)
		{
			if(i+7<config.size&&!memcmp(config.data+i,"ENTRY ",6))
			{
				break;
			}
			i=config_next_line(i);
		}
		if(i==config.size)
		{
			break;
		}
		x=i;
		i=config_next_line(i);
		color=0xe0;
		if(y==config_y)
		{
			color=0xffff;
		}
		p_str(config.data+x+6,i-x-7,0,y*16,color,video_buf,fblength,fbheight);
		++y;
	}
	if(y<max_configs)
	{
		max_configs=y;
	}
	color=0xe0;
	if(y==config_y)
	{
		color=0xffff;
	}
	p_str("Exit",4,0,y*16,color,video_buf,fblength,fbheight);
	memcpy(fbstart,video_buf,fbheight*fblength*4);
}
int boot_from_config(void)
{
	int y,i,x;
	struct ext2_image kernel,initramfs;
	int boot_ready;
	char buf[2048];
	y=-1;
	i=0;
	boot_ready=0;
	initramfs.data=0;
	initramfs.size=0;
	while(i<config.size)
	{
		if(i+7<config.size&&!memcmp(config.data+i,"ENTRY ",6))
		{
			++y;
		}
		else if(y==config_y)
		{
			if(i+7<config.size&&!memcmp(config.data+i,"LINUX ",6))
			{
				x=config_next_line(i)-1;
				config.data[x]=0;
				if(ext2_load_path(config.data+i+6))
				{
					error_message("Failed to find the Linux kernel.");
					return -30;
				}
				if(ext2_image_load(&kernel))
				{
					error_message("Failed to load the Linux kernel.");
					return -31;
				}
				config.data[x]='\n';
				boot_ready|=1;
			}
			else if(i+8<config.size&&!memcmp(config.data+i,"INITRD ",7))
			{
				x=config_next_line(i)-1;
				config.data[x]=0;
				if(ext2_load_path(config.data+i+7))
				{
					error_message("Failed to find initrd.");
					return -32;
				}
				if(ext2_image_load(&initramfs))
				{
					error_message("Failed to load initrd.");
					return -33;
				}
				config.data[x]='\n';
			}
			else if(i+9<config.size&&!memcmp(config.data+i,"CMDLINE ",8))
			{
				x=config_next_line(i)-1;
				x-=i+8;
				if(x<0)
				{
					error_message("CMDLINE format error");
					return -35;
				}
				if(x>2047)
				{
					x=2047;
				}
				memcpy(buf,config.data+i+8,x);
				buf[x]=0;
				boot_ready|=2;
			}
		}
		i=config_next_line(i);
	}
	if(boot_ready==3)
	{
		return boot_init(buf,&kernel,&initramfs);
	}
	error_message("Incomplete entry");
	return -34;
}
int main(void *handle,struct EFI_system_table *tab)
{
	unsigned int code;
	efihandle=handle;
	efitab=tab;
	if(graphics_init())
	{
		return -1;
	}
	if(block_init())
	{
		error_message("Failed to initialize block devices.");
		return -2;
	}
	if(ext2_init())
	{
		error_message("Failed to initialize the EXT2 filesystem.");
		return -3;
	}
	if(ext2_load_path("/boot.conf"))
	{
		error_message("Failed to find \"/boot.conf\".");
		return -4;
	}
	if(ext2_image_load(&config))
	{
		error_message("Failed to load \"/boot.conf\".");
		return -5;
	}
	max_configs=fbheight/16;
	p_entries();
	while(1)
	{
		code=getch();
		if((code&0xffff)==1)
		{
			if(config_y)
			{
				--config_y;
				p_entries();
			}
		}
		else if((code&0xffff)==2)
		{
			if(config_y<max_configs)
			{
				++config_y;
				p_entries();
			}
		}
		else if(code>>16==13)
		{
			if(config_y==max_configs)
			{
				return 0;
			}
			memset(fbstart,0,fbheight*fblength*4);
			return boot_from_config();
		}
	}
}
