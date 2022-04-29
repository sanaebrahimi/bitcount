%define SYS_write 1
%define STDOUT_FILENO 1

SECTION .data

	minus: db "-", 0
     

SECTION .bss

	v: resq 1
	c: resb 1
	n: resq 1
      _ch: resb 1
      neg: resb 1

SECTION .text



printf:
	mov [_ch], al
	mov rax, SYS_write
	mov rdi, STDOUT_FILENO
	mov rsi, _ch
	mov rdx, 1
	syscall
	ret
printnum: 
	  mov ah, 0	  
	  mov al, [c]
	  cmp al, 10       ;rbx == 10 or 100
          jl  .else
	  cmp al,100
	  jl .if
	  mov bl,100
	  div bl
	  ;mov bl, al
	  mov [c], ah
 	  add al,'0'
	  call printf
	  mov al, [c]
.if:
  	  mov ah, 0
	  mov bl, 10 
	  div bl
	  ;mov bl, al
	  mov [c], ah
	  add al, '0'
	  call printf
	  mov al, [c]
.else:
	  ;mov bl, al
	  add al, '0'
	  call printf

.done:
	  mov rdi, 0
	  ret
	  
myatoi:
		;mov r13, 0
	mov r12, 0
	mov [v],r12
	cmp r15b,'-'
	jne .while
	mov r12, 1
	mov [neg],r12
	inc r14
		;inc r13



.while:
	mov r15b, BYTE[r14]
		;mov al,r15b
		;call printf
		;mov al, `\n`
		;call printf
		;cmp r15b,0
		;je .done
	mov r12b,'0'
        cmp r15b,r12b  
	jl  .if
	
		;mov rax,r15
		;call printf
		;mov r12,58
	cmp r15b, '9'
	jg .if
		;mov al,`\n`
		;call printf
	;mov al,r15b
	;call printf

	sub r15b,'0'
	mov r12, 0
	mov r12b, 10 
	mov rax, [v]
	MUL  r12
	mov r13, 0
	mov r13b, r15b
	add rax, r13
	mov [v],rax
	inc r14
	jmp .while
.if:	
	
	mov rax, [neg]
	cmp rax, 0
	je  .done
	mov rax,[v]
	mov rcx,-1
	IMUL rax, rcx
	mov [v], rax
.done:
	ret



	
global _start

_start:
	
	mov r12b, 0
	mov [c], r12b
	mov r12, 2
	cmp [rsp], r12
	jl .done
	
	mov r14, [rsp+16]
		;mov rax,[r14]
		;call printf
		;mov al,`\n`
		;call printf
	mov r15b, BYTE[r14]
	call myatoi
		;mov al, [v]
		;call printf
		;mov n, v
	jmp .while2
	mov r13, 0
	cmp [v], r13
	jne .while2
	mov al, [v]

	mov r12b, 1
	cmp [neg], r12b
	je  .signed
	call printf
	mov al, `\n`
	call printf
	jmp .done
.while2:
	mov r13,0
	mov rax, [v]
	cmp rax, r13
	je .done
	mov r12, 1
	mov r14, [v]
	AND r14,r12
	cmp r14, r12
	jne .shift
	inc BYTE[c]
	jmp .shift
	jmp .while2
.shift:
	mov cl, 1
	mov rbx,[v]
	
	shr rbx,cl
	mov [v], rbx
	jmp .while2
.signed:
	mov rax, [v]
	cqo
	mov rax, rdx
	ret
	
.done:	
	;mov al, `\n`
	;call printf	
	mov al,[c]
	add al,'0'
	call printnum
	mov al,`\n`
	call printf
	mov rax, 60
	syscall 
	ret	
