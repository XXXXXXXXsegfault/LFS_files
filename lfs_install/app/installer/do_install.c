char loop_name[32];
char *devname;
int loopnum;
int devfd,loopfd;
struct loop_info64 loopinfo;
void write_pmbr(void)
{
	struct mbr_entry mbr[4];
	lseek(devfd,0,0);
	write(devfd,"\xeb\xfe",2);
	lseek(devfd,0x1be,0);
	memset(mbr,0,64);
	mbr[0].type=0xee;
	mbr[0].lba_start=1;
	if(selected_dev_size>0xffffffff)
	{
		mbr[0].lba_size=0xffffffff;
	}
	else
	{
		mbr[0].lba_size=selected_dev_size-1;
	}
	write(devfd,mbr,64);
	write(devfd,"\x55\xaa",2);
}
void write_gpt(void)
{
	static struct gpt_header header;
	static char zero[512];
	memcpy(header.signature,"EFI PART",8);
	header.revision=0x10000;
	header.header_size=0x5c;
	header.lba=1;
	header.lba_alter=selected_dev_size-1;
	header.first_usable=34;
	header.last_usable=selected_dev_size-34;
	getrandom(header.guid,16,1);
	header.entries_start=2;
	header.entries_count=128;
	header.entry_size=128;
	header.entries_crc32=gpt_crc32(gentries,sizeof(gentries));
	header.header_crc32=gpt_crc32(&header,0x5c);

	lseek(devfd,512,0);
	write(devfd,&header,0x5c);
	write(devfd,zero,512-0x5c);
	write(devfd,gentries,sizeof(gentries));


	lseek(devfd,selected_dev_size-33<<9,0);
	write(devfd,gentries,sizeof(gentries));
	
	header.lba=selected_dev_size-1;
	header.lba_alter=1;
	header.header_crc32=0;
	header.header_crc32=gpt_crc32(&header,0x5c);
	write(devfd,&header,0x5c);
	write(devfd,zero,512-0x5c);
}
int loop_init(void)
{
	int ctlfd;
	ctlfd=open("/dev/loop-control",2,0);
	if(ctlfd<0)
	{
		return 1;
	}
	if(!valid(loopnum=ioctl(ctlfd,LOOP_CTL_GET_FREE,0)))
	{
		close(ctlfd);
		return 1;
	}
	strcpy(loop_name,"/dev/loop");
	sprinti(loop_name,loopnum,1);
	loopfd=open(loop_name,2,0);
	if(loopfd<0)
	{
		close(ctlfd);
		return 1;
	}
	if(ioctl(loopfd,LOOP_SET_FD,devfd))
	{
		close(ctlfd);
		return 1;
	}
	if(ioctl(loopfd,LOOP_GET_STATUS64,&loopinfo))
	{
		close(ctlfd);
		return 1;
	}
	close(ctlfd);
	return 0;
}
void loop_fini(void)
{
	ioctl(loopfd,LOOP_CLR_FD,0);
	close(loopfd);
}
void set_loop_part(int n)
{
	loopinfo.offset=gentries[n].start<<9;
	loopinfo.sizelimit=gentries[n].end-gentries[n].start+1<<9;
	while(ioctl(loopfd,LOOP_SET_STATUS64,&loopinfo)<0);
}
void format_loop(char *program)
{
	char *argv[3];
	argv[0]=program;
	argv[1]=loop_name;
	argv[2]=NULL;
	if(fork()==0)
	{
		execv(program,argv);
		exit(1);
	}
	wait(NULL);
}
void copy_file(char *src,char *dst)
{
	char *argv[4];
	argv[0]="copy";
	argv[1]=src;
	argv[2]=dst;
	argv[3]=NULL;
	if(fork()==0)
	{
		execv("/bin/copy",argv);
		exit(1);
	}
	wait(NULL);
}
unsigned char bootid[16];
unsigned char rootid[16];
void do_install(void)
{
	int fd,fdi;
	static unsigned char buf[4096];
	int size,x;
	char *argv[6];
	write(1,"\033[2J\033[1;1H",10);
	devfd=open(selected_dev,2,0);
	if(devfd>=0)
	{
		selected_dev_size>>=9;
		write(1,"Change GPT Partitions\n",22);
		write_pmbr();
		write_gpt();
		mkdir("/mnt",0755);
		mkdir("/initramfs",0755);
		loop_init();
		write(1,"Create EFI Partition\n",21);
		getrandom(bootid,16,1);
		getrandom(rootid,16,1);
		set_loop_part(efi_p);
		format_loop("/bin/mkfs.fat");
		mount(loop_name,"/mnt","vfat",0,0);
		mkdir("/mnt/efi",0755);
		mkdir("/mnt/efi/boot",0755);
		fd=open("/mnt/efi/boot/bootx64.efi",578,0644);
		if(fd>=0)
		{
			fdi=open("/root/bootx64.efi",0,0);
			if(fdi>=0)
			{
				while((x=read(fdi,buf,0x1000))>0)
				{
					write(fd,buf,x);
				}
				lseek(fd,-64,2);
				write(fd,bootid,16);
				close(fdi);
			}
			close(fd);
		}
		while(umount("/mnt"));
		write(1,"Create Boot Partition\n",22);
		set_loop_part(boot_p);
		lseek(loopfd,0,0);
		write(loopfd,bootid,16);
		format_loop("/bin/mkfs.ext2");
		mount(loop_name,"/mnt","ext2",0,0);
		copy_file("/root/vmlinuz","/mnt/vmlinuz");
		copy_file("/root/boot.conf","/mnt/boot.conf");
		copy_file("/bin/init","/initramfs/init");
		fd=open("/initramfs/rootid",578,0644);
		if(fd>=0)
		{
			write(fd,rootid,16);
			close(fd);
		}
		if(fork()==0)
		{
			argv[0]="cpio";
			argv[1]="-p";
			argv[2]="/initramfs";
			argv[3]="/mnt/initramfs";
			argv[4]=NULL;
			execv("/bin/cpio",argv);
			exit(1);
		}
		wait(NULL);
		while(umount("/mnt"));
		write(1,"Create Root Partition\n",22);
		set_loop_part(root_p);
		lseek(loopfd,0,0);
		write(loopfd,rootid,16);
		format_loop("/bin/mkfs.ext3");
		sync();
		mount(loop_name,"/mnt","ext3",0,0);
		int pipefd[2];
		if(!pipe(pipefd))
		{
			if(fork()==0)
			{
				close(pipefd[1]);
				dup2(pipefd[0],0);
				argv[0]="cpio";
				argv[1]="-U";
				argv[2]="/mnt";
				argv[3]=NULL;
				execv("/bin/cpio",argv);
				exit(1);
			}
			if(fork()==0)
			{
				argv[0]="xz";
				argv[1]="-cd";
				argv[2]="/root/system.cpio.xz";
				argv[3]=NULL;
				dup2(pipefd[1],1);
				execv("/bin/xz",argv);
				exit(1);
			}
		}
		wait(NULL);
		wait(NULL);
		sync();
		while(umount("/mnt"));
		write(1,"\nComplete!\n",11);
		sync();
		sleep(10,0);
		while(1)
		{
			reboot(0xfee1dead,0x20112000,0x01234567,0);
		}
	}
}
