
bits 64
;  Call 
;  size_t ft_strlen(const char *s);
;  const char *s -> rdi address of the string


section  .data
		
		NULL		equ	0
	

	

global ft_strlen
section .text
ft_strlen 	:

	push	rbp		; save caller's context
	mov 	rbp, rsp 	; create current context
		
	mov	r11, -1	; init the temperary register r11

_loop	:

	inc	r11	
	cmp	byte [rdi + r11], NULL
	jne	_loop	
	mov rax, r11 
	pop	rbp
	ret