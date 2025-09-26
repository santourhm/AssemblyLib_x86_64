bits 64

; char *strdup(const char *s);
; const char * s -> rdi
; void *malloc(size_t size);


global  ft_strdup

section .text

extern  ft_strlen
extern  ft_strcpy
extern  malloc

ft_strdup   :

    push    rbp
    mov     rbp, rsp
    sub     rsp, 16

    mov     [rsp], rdi
    call    ft_strlen

    inc     rax         ; for '\0'
    mov     rdi, rax    ; save the length as the arg of malloc 
    call    malloc      ; allocate memory
    test    rax, rax
    jz      _end

    mov     rsi, [rsp]    ; save the address of const char *s 
    mov     rdi, rax    ; get the address given by malloc and give it to ft_strcpy as the dst arg
    push    rax
    call    ft_strcpy
    pop     rax   
    
_end    :
    add     rsp,16
    pop     rbp
    ret


    

    
