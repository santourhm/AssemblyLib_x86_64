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
		
	mov	r11, -1	; init the temperary register r11

_loop	:

	inc	r11	
	cmp	byte [rdi + r11*1], NULL
	jne	_loop	
	mov rax, r11 
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
	
	mov	r11, -1	; init the temperary register r11

loop_cpy : 

	inc	r11
	mov cl, byte [rsi + r11*1]
	mov byte [rdi + r11*1], cl	
	test cl, cl
	jne	loop_cpy	
	
	lea rax,  [rdi + r11*1] 
	pop	rbp
	ret


;  Call 
;  int ft_strcmp(const char *s1, const char *s2);
;  const char *s1 -> rdi address of the s1 string
;  const char *s2 -> rsi address of the s2 string

global ft_strcmp

ft_strcmp :

	push	rbp			; save caller's context
	mov 	rbp, rsp 	; create current context
	
loop_cmp :
	
    mov al, byte [rdi]     ; load *s1
    mov bl, byte [rsi]     ; load *s2

	cmp	al,bl
	jne .diff

	test al,al
	je	.end

	inc	rdi
	inc rsi

	jmp loop_cmp

.diff	:

	movzx	eax, al
	movzx	ebx, bl
	sub		eax,ebx
	jmp .end
	
.end	:
    
	pop rbp
	ret



; Call 
; size_t ft_write(int fd, const void * buf, size_t count);
; 	int fd -> rdi index of the file descriptor
;  	const void * buf -> rsi address the buffer to write on the fd
;  	size_t count : rdx size to write 


global ft_write

ft_write :

	push	rbp			; save caller's context
	mov 	rbp, rsp 	; create current context
	
	
