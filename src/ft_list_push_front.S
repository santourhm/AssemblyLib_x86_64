bits 64

; void ft_list_push_front(t_list **begin_list, void *data);

section .data


    T_LIST_DATA equ 0
    T_LIST_NEXT equ 8
    T_LIST_SIZE equ 16

    NULL        equ 0
    ENOMEM      equ 12



global  ft_list_push_front

extern malloc
extern __errno_location
section .text
ft_list_push_front :

            push    rbp
            mov     rbp,    rsp
            
            test    rdi, rdi
            jz      _end

            push    rdi
            push    rsi

            mov     rdi, T_LIST_SIZE
            call    malloc
            
            pop     rsi
            pop     rdi

            test    rax,rax
            jz      _end

            mov     [rax + T_LIST_DATA], rsi ; new_node->data = data;
            
            mov     rcx, [rdi]        ;  *begin_list address of the first element
            mov     [rax + T_LIST_NEXT], rcx
            mov     [rdi], rax

_end :
            pop     rbp
            ret

