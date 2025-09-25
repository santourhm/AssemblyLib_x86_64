bits 64


section  .data

		NULL	equ	0

section .text

;  Call 
;  size_t ft_strlen(const char *s);
;  const char *s -> rdi address of the string

global ft_strlen

ft_strlen 	:

	push	rbp		; save caller's context
	mov 	rbp, rsp 	; create current context
		
	mov	r10, -1	; init the temperary register r10

_loop	:

	inc	r10	
	cmp	byte [rdi + r10*1], NULL
	jne	_loop	
	mov rax, r10 
	pop	rbp
	ret
	
	
		
	 	
