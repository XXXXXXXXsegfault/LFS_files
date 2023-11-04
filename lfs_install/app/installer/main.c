#include "../../include/malloc.c"
#include "../../include/mem.c"
#include "../../include/ioctl/termios.c"
#include "../../include/ioctl/blk.c"
#include "../../include/ioctl/loop.c"
#include "../../include/signal.c"
#include "../../include/poll.c"
#include "../../include/gpt.c"
#include "../../include/dirent.c"
#include "../../include/stat.c"
#include "../../include/iformat.c"
struct termios term,old_term;
struct winsize winsz;
long int kbmode;
int mode,submode;
int selected;
int config_state;
int list_y;
void *xmalloc(int size)
{
	void *ptr;
	do
	{
		ptr=malloc(size);
	}
	while(!size||!ptr);
	return ptr;
}
void SH_exit(int sig)
{
	ioctl(0,KDSKBMODE,kbmode);
	ioctl(0,TCSETS,&old_term);
	write(1,"\033[2J\033[1;1H",10);
	write(1,"\033[0m",4);
	exit(0);
}
int term_init(void)
{
	if(ioctl(0,TCGETS,&old_term)<0)
	{
		return 1;
	}
	memcpy(&term,&old_term,sizeof(term));
	term.lflag&=~0xb;
	if(ioctl(0,TCSETS,&term)<0)
	{
		return 1;
	}
	if(ioctl(0,KDGKBMODE,&kbmode)<0)
	{
		ioctl(0,TCSETS,&old_term);
		return 1;
	}
	if(ioctl(0,KDSKBMODE,2)<0)
	{
		ioctl(0,TCSETS,&old_term);
		return 1;
	}
	return 0;
}
int get_c(void)
{
	struct pollfd pfd;
	int c;
	pfd.fd=0;
	pfd.events=POLLIN;
	poll(&pfd,1,-1);
	c=0;
	read(0,&c,1);
	if(c&0x80)
	{
		return 0;
	}
	return c;
}
void cursor_move(int x,int y)
{
	char buf[32];
	strcpy(buf,"\033[");
	sprinti(buf,y,1);
	strcat(buf,";");
	sprinti(buf,x,1);
	strcat(buf,"H");
	write(1,buf,strlen(buf));
}
#include "mode1.c"
#include "mode2.c"
#include "mode0.c"
#include "mode3.c"
#include "do_install.c"
int main(void)
{
	int c;
	if(term_init())
	{
		return 1;
	}
	signal(SIGINT,SH_exit);
	signal(SIGQUIT,SIG_IGN);
	write(1,"\033[2J",4);
	mode0_pscreen();
	while(1)
	{
		c=get_c();
#ifdef DEBUG
		if(c==16&&mode!=2||c=='q'&&mode==2)
		{
			SH_exit(1);
		}
#endif
		if(c)
		{
			if(mode==0)
			{
				mode0_key_handler(c);
			}
			else if(mode==1)
			{
				mode1_key_handler(c);
			}
			else if(mode==2)
			{
				mode2_key_handler(c);
			}
			else if(mode==3)
			{
				mode3_key_handler(c);
			}
			if(mode==0)
			{
				mode0_pscreen();
			}
			else if(mode==1)
			{
				mode1_pscreen();
			}
			else if(mode==3)
			{
				mode3_pscreen();
			}
		}
	}
}
