#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

extern size_t   ft_strlen(const char *s);
extern char     *ft_strcpy(char *dst, const char *src);
extern ssize_t  ft_write(int fd, const void *buf, size_t count);
extern int      ft_strcmp(const char *s1, const char *s2);
extern char     *ft_strdup(const char *s);
extern ssize_t  ft_read(int fd, void *buf, size_t count);


int main(void)
{
	const char* s1 = "salut la vie c'est cool";
	char		*s2;
	char		*s3;
	int			fd;

	printf("--strlen--\nlibc: %ld\nft: %ld\n", strlen(s1), ft_strlen(s1));
	printf("--strlen--\nlibc: %ld\nft: %ld\n", strlen(""), ft_strlen(""));

	s2 = malloc(sizeof(char) * (strlen(s1) + 1));
	if (!s2)
		return 1;
	ft_strcpy(s2, s1);
	printf("--strcpy--\nsrc: %s\ndest: %s\n", s1, s2);

	ft_write(1, "--write--\n", 10);
	ft_write(1, s2, ft_strlen(s2));
	ft_write(1, "\n", 1);

	printf("--strcmp--\nlibc: %d\nft: %d\n", strcmp(s1, s2), ft_strcmp(s1, s2));
	printf("--strcmp--\nlibc: %d\nft: %d\n", strcmp("a", "b"), ft_strcmp("a", "b"));
	printf("--strcmp--\nlibc: %d\nft: %d\n", strcmp("b", "a"), ft_strcmp("b", "a"));
	printf("--strcmp--\nlibc: %d\nft: %d\n", strcmp("salut la vie c'est cool", "salut"), ft_strcmp("salut la vie c'est cool", "salut"));

	s3 = ft_strdup(s2);
	if (!s3)
		perror(NULL);
	else
		printf("--strdup--\n%s\n", s3);

	ft_write(1, "--write--\n", 10);
	errno = 0;
	ft_write(1, "writing -1 to test errno\n", 25);
	ft_write(1, NULL, -1);
	if (errno)
		perror(NULL);

	fd = open("Makefile", O_RDONLY);
	errno = 0;
	printf("--read--\nreaded: %ld\n", ft_read(fd, s2, 23));
	close(fd);
	if (errno)
		perror(NULL);
	else
	{
		ft_write(1, s2, 22);
		if (errno)
			perror(NULL);
	}

	free(s2);
	free(s3);
}
