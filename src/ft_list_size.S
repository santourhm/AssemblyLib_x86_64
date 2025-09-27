bits 64

; int ft_list_size(t_list *begin_list);

section .data


    T_LIST_DATA equ 0
    T_LIST_NEXT equ 8
    T_LIST_SIZE equ 16

    NULL        equ 0

global  ft_list_size

section .text
ft_list_size :

            push    rbp
            mov     rbp,    rsp
            
            test    rdi,    rdi
            jz      _end_null
            mov     rax,    1
_loop       :

            cmp    qword [rdi + T_LIST_NEXT ] , NULL
            je      _end
            inc     rax
            mov     rdi,    [rdi + T_LIST_NEXT ]
            jmp     _loop

_end_null   :
            xor rax,rax         
_end :
            pop     rbp
            ret

