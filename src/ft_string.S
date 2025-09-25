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

;  Call 
;  char *stpcpy(char *restrict dst, const char *restrict src);
;  char *restrict dst -> rdi address of the dst string
;  char *restrict src -> rsi address of the src string

global ft_stpcpy

ft_stpcpy :

	push	rbp		; save caller's context
	mov 	rbp, rsp 	; create current context
	
	mov	r10, -1	; init the temperary register r10

loop_cpy : 

	inc	r10
	mov cl, byte [rsi + r10*1]
	mov byte [rdi + r10*1], cl	
	test cl, cl
	jne	loop_cpy	
	
	lea rax,  [rdi + r10*1] 
	pop	rbp
	ret

ft_strcmp


;  Call 
;  char *stpcpy(char *restrict dst, const char *restrict src);
;  char *restrict dst -> rdi address of the dst string
;  char *restrict src -> rsi address of the src string

global ft_strcmp

ft_strcmp :

	push	rbp		; save caller's context
	mov 	rbp, rsp 	; create current context
	
	mov	r10, -1	; init the temperary register r10

	mov rbx, 0
	mov rcx, 0

loop_str1 : 

	inc	r10
	mov cl, byte [rsi + r10*1]
	movzx rax, cl 
	add rdx, rax 
	test  cl,cl
	jne	loop_str1	
	mov r10, -1

loop_str2 : 

	inc	r10
	mov cl, byte [rdi + r10*1]
	movzx rax, cl 
	sub rdx, rax 
	test  cl,cl
	jne	loop_str2	

	mov rax, rdx 
	pop	rbp
	ret

