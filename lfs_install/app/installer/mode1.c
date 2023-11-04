void mode0_init(void);
int mode2_init(void);
char selected_dev[128];
long selected_dev_size;
#define EFI_PART "\x28\x73\x2a\xc1\x1f\xf8\xd2\x11\xba\x4b\x00\xa0\xc9\x3e\xc9\x3b"
#define MSDATA_PART "\xa2\xa0\xd0\xeb\xe5\xb9\x33\x44\x87\xc0\x68\xb6\xb7\x26\x99\xc7"
struct dev
{
	char path[128];
	unsigned long size;
	struct dev *next;
} *dev;
int num_dev;
int num_part_entries;
int root_p,boot_p,efi_p;
struct gpt_entry gentries[128];
int is_partition(int fd)
{
	struct hd_geometry hg;
	if(ioctl(fd,HDIO_GETGEO,&hg)<0)
	{
		return 1;
	}
	if(hg.start)
	{
		return 1;
	}
	return 0;
}
void scan_dev(void)
{
	struct dev *n,*end;
	int fd,fd2;
	struct DIR dp;
	struct dirent *dir;
	struct stat st;
	long size;
	while(n=dev)
	{
		dev=n->next;
		free(n);
	}
	end=NULL;
	num_dev=0;
	fd=open("/dev",0,0);
	if(fd>=0)
	{
		dir_init(fd,&dp);
		while(dir=readdir(&dp))
		{
			if(!fstatat(fd,dir->name,&st,0)&&(st.mode&0170000)==STAT_BLK)
			{
				fd2=openat(fd,dir->name,0,0);
				if(fd2>=0)
				{
					size=lseek(fd2,0,2);
					if(size>0x100000000&&!is_partition(fd2))
					{
						n=xmalloc(sizeof(*n));
						strcpy(n->path,"/dev/");
						strcat(n->path,dir->name);
						n->size=size;
						n->next=NULL;
						if(end)
						{
							end->next=n;
						}
						else
						{
							dev=n;
						}
						end=n;
						++num_dev;
					}
					close(fd2);
					
				}
			}
		}

		close(fd);
	}
}
void out_size(long size)
{
	int buf[64];
	buf[0]=0;
	if(size<0x40000000)
	{
		sprinti(buf,size>>20,1);
		strcat(buf,".");
		sprinti(buf,(size&0xfffff)*100>>20,2);
		strcat(buf," MB");
	}
	else
	{
		sprinti(buf,size>>30,1);
		strcat(buf,".");
		sprinti(buf,(size&0x3fffffff)*100>>30,2);
		strcat(buf," GB");
	}
	write(1,buf,strlen(buf));
}
void p_dev(void)
{
	struct dev *n;
	int x,l;
	n=dev;
	x=1;
	while(n)
	{
		write(1,"        ",8);
		if(x==selected)
		{
			write(1,"\033[30m\033[47m",10);
		}
		l=strlen(n->path);
		write(1,n->path,l);
		while(l<32)
		{
			write(1," ",1);
			++l;
		}
		out_size(n->size);
		write(1,"\033[0m\n",5);
		n=n->next;
		++x;
	}
}
void load_pt_gpt(int fd,long lba_alter)
{
	int x;
	struct gpt_entry entries[128];
	lseek(fd,1024,0);
	read(fd,gentries,sizeof(gentries));
	lseek(fd,(lba_alter-32)*512,0);
	read(fd,entries,sizeof(entries));
	x=0;
	while(x<128)
	{
		if(!memcmp(gentries[x].type,"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",16))
		{
			memcpy(gentries+x,entries+x,sizeof(struct gpt_entry));
		}
		++x;
	}
}
void load_pt_mbr(int fd)
{
	static struct mbr_entry entries[8];
	int x;
	long ext_start;
	lseek(fd,0x1be,0);
	read(fd,entries,64);
	x=0;
	ext_start=0;
	while(x<4)
	{
		if(entries[x].type==5)
		{
			ext_start=entries[x].lba_start;
			lseek(fd,512*ext_start+0x1be,0);
			read(fd,entries+4,64);
			x=4;
			while(x<8)
			{
				entries[x].lba_start+=ext_start;
				++x;
			}
			break;
		}
		++x;
	}
	x=0;
	while(x<8)
	{
		if(entries[x].type&&entries[x].type!=5)
		{
			memcpy(gentries[x].type,MSDATA_PART,16);
			getrandom(gentries[x].guid,16,1);
			gentries[x].start=entries[x].lba_start;
			gentries[x].end=gentries[x].start+entries[x].lba_size-1;
			memcpy(gentries[x].name,"D\0a\0t\0a\0",8);
		}
		++x;
	}
}
int load_pt(void)
{
	int fd;
	struct gpt_header gpth;
	memset(gentries,0,sizeof(gentries));
	fd=open(selected_dev,0,0);
	if(fd<0)
	{
		return 1;
	}
	lseek(fd,512,0);
	read(fd,&gpth,sizeof(gpth));
	if(memcmp(gpth.signature,"EFI PART",8))
	{
		load_pt_mbr(fd);
		close(fd);
		return 1;
	}
	else
	{
		load_pt_gpt(fd,gpth.lba_alter);
		close(fd);
		return 0;
	}
	
}
long pt_next_pos(long pos,int *s)
{
	int x;
	long ret;
	ret=-1;
	x=0;
	while(x<128)
	{
		if(memcmp(gentries[x].type,"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00",16))
		{
			if(pos==gentries[x].start)
			{
				*s=x+1;
				return gentries[x].end+1;
			}
			else if(pos<gentries[x].start&&(ret==-1||ret>gentries[x].start))
			{
				ret=gentries[x].start;
			}
		}
		++x;
	}
	*s=0;
	return ret;
}
int p_pt_entry(int n)
{
	long pos,p_end;
	int s,l,x;
	char buf[70];
	pos=2048;
	p_end=pt_next_pos(pos,&s);
	x=n;
	while(n)
	{
		pos=p_end;
		if(pos==-1)
		{
			return 1;
		}
		p_end=pt_next_pos(pos,&s);
		--n;
	}
	if(p_end==-1)
	{
		p_end=(selected_dev_size>>9)-33;
	}
	if(x+1==selected)
	{
		write(1,"\033[30m\033[47m",10);
	}
	if(s)
	{
		strcpy(buf,"    Partition ");
		sprinti(buf,s,1);
		l=strlen(buf);
		write(1,buf,l);
	}
	else
	{
		write(1,"    Free Space",14);
		l=14;
	}
	while(l<30)
	{
		write(1," ",1);
		++l;
	}
	l=0;
	if(s)
	{
		if(s==efi_p+1)
		{
			write(1,"EFI",3);
			l=3;
		}
		else if(s==boot_p+1)
		{
			write(1,"Boot",4);
			l=4;
		}
		else if(s==root_p+1)
		{
			write(1,"Root",4);
			l=4;
		}
	}
	write(1,"\033[0m",4);
	while(l<8)
	{
		write(1," ",1);
		++l;
	}
	out_size((p_end-pos)*512);
	write(1,"\n",1);
	return 0;
}
void delete_partition(int n)
{
	long pos,p_end;
	int s;
	char buf[70];
	pos=2048;
	p_end=pt_next_pos(pos,&s);
	while(n)
	{
		pos=p_end;
		if(pos==-1)
		{
			return;
		}
		p_end=pt_next_pos(pos,&s);
		--n;
	}
	if(p_end==-1)
	{
		p_end=(selected_dev_size>>9)-33;
	}
	if(!s)
	{
		return;
	}
	--s;
	memset(gentries[s].type,0,16);
	if(s==efi_p)
	{
		efi_p=-1;
	}
	if(s==boot_p)
	{
		boot_p=-1;
	}
	if(s==root_p)
	{
		root_p=-1;
	}
}
void mode1_key_handler(int code)
{
	int n;
	struct dev *p;
	if(code==28)
	{
		if(selected==0)
		{
			mode0_init();
			return;
		}
	}
	if(submode==0) // select device
	{
		if(code==103)
		{
			if(selected)
			{
				--selected;
			}
		}
		else if(code==108)
		{
			if(selected<num_dev)
			{
				++selected;
			}
		}
		else if(code==28)
		{
			p=dev;
			n=1;
			while(p&&n<selected)
			{
				++n;
				p=p->next;
			}
			if(p)
			{
				strcpy(selected_dev,p->path);
				selected_dev_size=p->size;
				selected=0;
				write(1,"\033[?25l\033[2J",10);
				if(load_pt())
				{
					submode=1;
				}
				else
				{
					submode=2;
				}
			}
		}
	}
	else if(submode==1) // warning page
	{
		if(code==28)
		{
			if(selected==1)
			{
				write(1,"\033[?25l\033[2J",10);
				submode=2;
				selected=0;
			}
		}
		else if(code==103)
		{
			selected=0;
		}
		else if(code==108)
		{
			selected=1;
		}
	}
	else if(submode==2) // partitioning
	{
		if(code==103)
		{
			if(selected)
			{
				--selected;
			}
		}
		else if(code==108)
		{
			if(selected<num_part_entries)
			{
				++selected;
			}
		}
		else if(code==32)
		{
			if(selected)
			{
				delete_partition(selected-1);
				write(1,"\033[?25l\033[2J",10);
			}
			selected=0;
		}
		else if(code==46)
		{
			if(selected)
			{
				mode2_init();
			}
		}
		else if(code==31)
		{
			if(efi_p==-1||boot_p==-1||root_p==-1)
			{
				submode=3;
				selected=0;
				write(1,"\033[?25l\033[2J",10);
			}
			else
			{
				config_state|=1;
				mode0_init();
			}
		}
	}
	else if(submode==3) // note page
	{
		if(code==28)
		{
			if(selected==1)
			{
				write(1,"\033[?25l\033[2J",10);
				submode=2;
				selected=0;
			}
		}
		else if(code==103)
		{
			selected=0;
		}
		else if(code==108)
		{
			selected=1;
		}
	}
}
void mode1_pscreen(void)
{
	write(1,"\033[?25l",6);
	write(1,"\033[1;1H",6);
	if(selected==0)
	{
		write(1,"\033[30m\033[47m",10);
	}
	write(1,"Exit",4);
	write(1,"\033[0m    ",8);
	if(submode==0)
	{
		write(1,"Where do you want to install LFS Linux?\n",40);
		p_dev();
		cursor_move(9,selected+1);
	}
	else if(submode==1)
	{
		write(1,"    \033[31mWARNING\033[0m\n",21);
		write(1,"    About to create GPT partition table\n",40);
		write(1,"    It may overwrite your old bootloader\n",41);
		write(1,"    and make your old OS not bootable!\n",39);
		write(1,"\n        ",9);
		if(selected==1)
		{
			write(1,"\033[30m\033[47m",10);
		}
		write(1,"Continue",8);
		write(1,"\033[0m",4);
		if(selected==1)
		{
			write(1,"\033[6;9H",6);
		}
	}
	else if(submode==2)
	{
		write(1,"    C - Create Partition, D - Delete Partition, S - OK\n",55);
		num_part_entries=0;
		while(!p_pt_entry(num_part_entries))
		{
			++num_part_entries;
		}
		cursor_move(5,selected+1);
	}
	else if(submode==3)
	{
		write(1,"    \033[32mNOTE\033[0m\n",18);
		write(1,"    You need to create an EFI partition,\n",41);
		write(1,"    a boot partition and a root partition\n",42);
		write(1,"    to continue\n",16);
		write(1,"\n        ",9);
		if(selected==1)
		{
			write(1,"\033[30m\033[47m",10);
		}
		write(1,"OK",2);
		write(1,"\033[0m",4);
		if(selected==1)
		{
			write(1,"\033[6;9H",6);
		}
	}
	if(selected==0)
	{
		write(1,"\033[1;1H",6);
	}
	write(1,"\033[?25h",6);
}
void mode1_init(void)
{
	selected=0;
	mode=1;
	submode=0;
	config_state&=~1;
	list_y=0;
	scan_dev();
	boot_p=-1;
	root_p=-1;
	efi_p=-1;
	write(1,"\033[?25l\033[2J",10);
}
