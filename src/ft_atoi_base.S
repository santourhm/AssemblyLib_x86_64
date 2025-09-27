bits 64

; int ft_atoi_base(const char *str, const char *base);
; const char *str  <- rdi ( A pointer to the string you need to convert)
; const char *base  <- rsi (A pointer to a string that defines the set of valid digits for the base (e.g., "01" for binary, "0123456789" for decimal).)


section .data   


global ft_atoi_base

extern  ft_strlen

section .text

ft_atoi_base    :

            push    rbp
            push    rbx
            mov     rbp,    rsp
            sub     rsp,    24 
            
            mov     [rbp-8],    rdi             ; str
            mov     [rbp-16],   rsi             ; base

            mov     rdi,        rsi
            call    ft_strlen                          
            mov     qword [rbp - 24],    rax    ; len(base []) ->  rbp - 32
        
            xor     rbx, rbx                    ; result = 0
            xor     rcx, rcx                    ; index = 0

cnvrt   :

            mov     rax, [rbp-8]         ; str ptr
            mov     dil, byte [rax+rcx]  ; load str[rcx]
            test    dil, dil
            jz      _end  
            
            mov     rsi, [rbp - 16]
            call    _char_is_valid
            cmp     rax, 0
            jl      _end   

            imul    rbx, qword [rbp-24]
            add     rbx, rax

            inc     rcx
            jmp     cnvrt

_end            :
            mov     rax, rbx
            add     rsp, 24
            pop     rbx
            pop     rbp
            ret


global _char_is_valid
_char_is_valid:

            push    rbp
            mov     rbp, rsp

            mov     rax, -1        
            mov     r11, -1        

.loop_valid:

            inc     r11
            mov     al, byte [rsi + r11]   ; load base[i]
            test    al, al
            jz      .not_valid             ; if 0 → end of string

            cmp     al, dil                ; compare with input char
            je      .is_valid              ; if match → success
            jmp     .loop_valid

.not_valid:

            mov     rax, -1
            jmp     .done

.is_valid:

            mov     rax, r11

.done:

            pop     rbp
            ret







