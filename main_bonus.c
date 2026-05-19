#include <unistd.h>
#include <stdio.h>

extern int ft_atoi_base(char *str, char* base);

int main()
{
	printf("%d\n", ft_atoi_base(" \n\t --+++++++-jj", "abcdefghij"));
}
