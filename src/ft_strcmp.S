bits 64
;  Call 
;  int ft_strcmp(const char *s1, const char *s2);
;  const char *s1 -> rdi address of the s1 string
;  const char *s2 -> rsi address of the s2 string

section  .data
		

global ft_strcmp
section .text
	
ft_strcmp :
    
    push    rbp
    mov     rbp, rsp

loop_cmp :

    mov al, byte [rdi]     ; load *s1
    mov bl, byte [rsi]     ; load *s2

	cmp	al,bl
	jne .diff

	test al,al
	je	.equal

	inc	rdi
	inc rsi

	jmp loop_cmp

.diff	:

	movsx	eax, al
	movsx	ebx, bl
	sub		eax,ebx
	jmp .end

.equal:
    xor     rax, rax 

.end	:
    pop rbp
	ret
