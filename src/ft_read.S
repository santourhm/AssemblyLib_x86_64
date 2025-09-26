bits 64

section .data

    SYS_read    equ 0           

extern __errno_location

global ft_read
section .text
ft_read:
    mov     rax, SYS_read       
    syscall                     

    cmp     rax, 0             
    jl      .error             
    ret                         

.error:

    neg     rax                
    mov     r10, rax            
    
    call __errno_location wrt ..plt   
                                
    mov     [rax], r10         
    mov     rax, -1             
    ret