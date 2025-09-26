#ifndef LIBASM_H
#define LIBASM_H
#include <unistd.h>

#include <stddef.h> 

size_t  ft_strlen(const char *s);
char   *ft_stpcpy(char *restrict dst, const char *restrict src);
int     ft_strcmp(const char *s1, const char * s2);
size_t ft_write(int fd, const void * buf, size_t count);

#endif