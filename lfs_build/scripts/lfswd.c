#include <stdio.h>
#include <string.h>
#include <unistd.h>
char buf[1024];
int main(void)
{
	int x;
	char c;
	if(getuid()!=0)
	{
		fprintf(stderr,"LFS should be built with UID 0.\n");
		return 1;
	}
	if(getcwd(buf,1024)==NULL)
	{
		fprintf(stderr,"Please move the source directory to appropriate position.\n");
		fprintf(stderr,"The path name is too long.\n");
		return 1;
	}
	x=0;
	while(c=buf[x])
	{
		if(!(c>='A'&&c<='Z'||c>='a'&&c<='z'||c>='0'&&c<='9'||c=='-'||c=='_'||c=='/'||c=='.'))
		{
			fprintf(stderr,"Please move the source directory to appropriate position.\n");
			fprintf(stderr,"The path name contains special characters.\n");
			return 1;
		}
		++x;
	}
	strcat(buf,"/lfs");
	puts(buf);
	return 0;
}
