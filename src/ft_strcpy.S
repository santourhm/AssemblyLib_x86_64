bits 64
;  Call 
;  char *stpcpy(char *restrict dst, const char *restrict src);
;  char *restrict dst -> rdi address of the dst string
;  char *restrict src -> rsi address of the src string
section  .data
		
		NULL	equ	0		



global ft_strcpy  
section .text
ft_strcpy :

	push	rbp		; save caller's context
	mov 	rbp, rsp 	; create current context
	
	mov	r11, -1	; init the temperary register r11

loop_cpy : 

	inc	r11
	mov cl, byte [rsi + r11]
	mov byte [rdi + r11], cl	
	test cl, cl
	jne	loop_cpy	
	
	lea rax,  [rdi + r11] 
	pop	rbp
	ret

