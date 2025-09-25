#include <stdio.h>
#include <string.h>

size_t ft_strlen(const char *s);

int main(void) 
{
    const char *s1 = "Hello, World!";
    const char *s2 = "";
    const char *s3 = "42";

    printf("ft_strlen(\"%s\") = %zu\n", s1, ft_strlen(s1));
    printf("strlen(\"%s\")    = %zu\n\n", s1, strlen(s1));

    printf("ft_strlen(\"%s\") = %zu\n", s2, ft_strlen(s2));
    printf("strlen(\"%s\")    = %zu\n\n", s2, strlen(s2));

    printf("ft_strlen(\"%s\") = %zu\n", s3, ft_strlen(s3));
    printf("strlen(\"%s\")    = %zu\n", s3, strlen(s3));

    return 0;
}
