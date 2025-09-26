bits 64

section .data

    SYS_write   equ 1           

extern __errno_location

global ft_write
section .text
ft_write:

    mov     rax, SYS_write      ; Set syscall number
    syscall                     ; Execute syscall

    cmp     rax, 0              ; Check the return value
    jl      .error              ; Jump if Less than 0 
    ret                         ; Success, rax has the byte count. Return.

.error:
    neg     rax                 ; rax was negative, make it positive
    mov     r10, rax            ; Save the positive error code in r10
    
    call __errno_location wrt ..plt    ; Call the libc function to get errno's address
                                
    
    mov     [rax], r10          ; Store the error code at the address of errno
    mov     rax, -1             
    ret