#define _BUILD_INTERNAL_
#include "boot/build.c"
#include "app/build.c"
#include "include/malloc.c"
#include "include/ioctl/termios.c"
#include "install/build.c"

void copy_file(char *src,char *dst)
{
	char *argv[4];
	argv[0]="copy";
	argv[1]=src;
	argv[2]=dst;
	argv[3]=0;
	xexec_program("build/root/bin/copy",argv);
}
void mkrootid(void)
{
	int fd;
	char rootid[16];
	fd=open("build/root/rootid",578,0644);
	if(fd<0)
	{
		exit(1);
	}
	getrandom(rootid,16,1);
	write(fd,rootid,16);
	close(fd);
}
int main(void)
{
	char *msg;
	char *argv[5];
	int fd,pipefd[2],fdo;
	static char buf[4096];
	int size;
	int pid,status;
	if(access("/bin/xz",1))
	{
		write(2,"XZ needed but not found\n",24);
		return 1;
	}
	msg="Start Building\n";
	write(1,msg,strlen(msg));
	xmkdir("build",0755);
	xmkdir("build/mnt",0755);
	xmkdir("build/tmp",0755);
	xmkdir("build/boot",0755);
	xmkdir("build/root",0755);
	xmkdir("build/root/bin",0755);
	xmkdir("build/root/dev",0755);
	xmkdir("build/root/root",0755);
	build_boot("build/boot/bootx64.efi");
	build_apps();
	write(1,"Creating system.img\n",20);
	write(1,"This may take half an hour\n",27);
	mkrootid();
	copy_file("src/busybox","build/root/bin/xz");
	copy_file("src/vmlinuz","build/boot/vmlinuz");
	argv[0]="cpio";
	argv[1]="-p";
	argv[2]="build/root";
	argv[3]="build/boot/initramfs";
	argv[4]=0;
	xexec_program("build/root/bin/cpio",argv);
	argv[2]="sysroot";
	argv[3]="build/system.cpio";
	xexec_program("build/root/bin/cpio",argv);
	if(pipe(pipefd))
	{
		return 30;
	}

	argv[0]="xz";
	argv[1]="build/system.cpio";
	argv[2]=NULL;
	xexec_program("/bin/xz",argv);

	struct stat st;
	long total_size;
	total_size=0;
	if(stat("build/system.cpio.xz",&st))
	{
		return 37;
	}
	total_size+=st.size;
	total_size=total_size*33/32+1048576*128;
	total_size=total_size>>20<<20;
	fd=open("install.img",578,0644);
	if(fd<0)
	{
		return 39;
	}
	memset(buf,0,4096);
	while(total_size>0)
	{
		write(fd,buf,4096);
		total_size-=4096;
	}
	close(fd);

	build_installer2("build/install.run");
	argv[0]="install.run";
	argv[1]="install.img";
	argv[2]=NULL;
	execv("build/install.run",argv);

	return 34;
}
