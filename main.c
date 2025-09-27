#include <stdio.h>
#include <string.h>
#include <stdlib.h> // For malloc, free
#include <unistd.h> // For write, read
#include <errno.h>  // For errno and EBADF
#include "include/libasm.h"

// Helper for pretty printing test results
void print_result(int success) {
    if (success) {
        printf("  > Result: \033[32m[PASS]\033[0m\n");
    } else {
        printf("  > Result: \033[31m[FAIL]\033[0m\n");
    }
    printf("----------------------------------------\n");
}

void test_strlen() {
    printf("===== Testing ft_strlen =====\n");
    const char *tests[] = {"Hello, World!", "", "a", "1234567890"};
    for (int i = 0; i < 4; i++) {
        size_t lib_ret = strlen(tests[i]);
        size_t my_ret = ft_strlen(tests[i]);
        printf("Testing: \"%s\"\n", tests[i]);
        printf("  > libc: %zu, your: %zu\n", lib_ret, my_ret);
        print_result(lib_ret == my_ret);
    }
}

void test_strcpy() {
    printf("===== Testing ft_strcpy =====\n");
    char buffer1[100];
    char buffer2[100];
    const char *src = "This is a test string.";
    
    strcpy(buffer1, src);
    ft_strcpy(buffer2, src);
    
    printf("Copying \"%s\"\n", src);
    printf("  > libc buffer: \"%s\"\n", buffer1);
    printf("  > your buffer: \"%s\"\n", buffer2);
    print_result(strcmp(buffer1, buffer2) == 0);
}

void test_strcmp() {
    printf("===== Testing ft_strcmp =====\n");
    const char *s1 = "Hamza";
    const char *s2 = "Hhawla";
    const char *s3 = "Hello";
    
    int res_lib = strcmp(s2, s1);
    int res_my = ft_strcmp(s2, s1);
    printf("Comparing \"%s\" and \"%s\"\n", s2, s1);
    printf("  > libc: %d, your: %d\n", res_lib, res_my);
    // strcmp returns >0, 0, or <0. The exact value can differ, so we only check the sign.
    print_result((res_lib > 0 && res_my > 0) || (res_lib < 0 && res_my < 0) || (res_lib == 0 && res_my == 0));

    res_lib = strcmp(s3, s3);
    res_my = ft_strcmp(s3, s3);
    printf("Comparing \"%s\" and \"%s\"\n", s3, s3);
    printf("  > libc: %d, your: %d\n", res_lib, res_my);
    print_result(res_lib == res_my);
}

void test_write() {
    printf("===== Testing ft_write =====\n");
    const char *msg = "Hello from ft_write!\n";
    
    // Test 1: Success
    printf("Testing write to stdout (fd 1):\n");
    ssize_t my_ret = ft_write(1, msg, strlen(msg));
    printf("  > ft_write returned: %zd\n", my_ret);
    print_result(my_ret == (ssize_t)strlen(msg));

    // Test 2: Failure
    printf("Testing write to bad fd (-1):\n");
    errno = 0; // Reset errno
    my_ret = ft_write(-1, msg, strlen(msg));
    printf("  > ft_write returned: %zd, errno: %d\n", my_ret, errno);
    print_result(my_ret == -1 && errno == EBADF);
}

void test_strdup() {
    printf("===== Testing ft_strdup =====\n");
    const char *src = "This string should be duplicated.";
    char *my_dup = ft_strdup(src);
    
    printf("Duplicating string: \"%s\"\n", src);
    if (my_dup) {
        printf("  > Original ptr: %p\n", (void*)src);
        printf("  > New ptr:      %p\n", (void*)my_dup);
        printf("  > New string:   \"%s\"\n", my_dup);
        print_result(strcmp(src, my_dup) == 0 && src != my_dup);
        free(my_dup); // CRITICAL: Always free memory you allocate!
    } else {
        printf("  > ft_strdup returned NULL\n");
        print_result(0); // Fail if it returns NULL for a valid string
    }
}


void test_ft_atoi_base(void)
{
    printf("===== Testing ft_atoi_base =====\n");

    int cnvrt;
    const char *list_test_src[]  = {"11","123","00001111","1A2"};
    const char *list_test_base[] = {"01","0123456789","01","0123456789ABCDEF"};
    int list_test_res[]          = {3,123,15,418};

    for (int i = 0; i < 4; i++) {
        cnvrt = ft_atoi_base(list_test_src[i], list_test_base[i]);
        printf("  > Input: \"%s\" in base \"%s\" -> got %d, expected %d\n",
               list_test_src[i], list_test_base[i], cnvrt, list_test_res[i]);

        if (cnvrt != list_test_res[i]) {
            print_result(0);
            return;
        }
    }

    print_result(1);
}

int main(void) 
{
    test_strlen();
    test_strcpy();
    test_strcmp();
    test_write();
    test_strdup();
    test_ft_atoi_base();
    return 0;
}