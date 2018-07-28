str_trim:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR [rbp-24], rdi
; la §première§ partie de for() commence ici
	mov	rax, QWORD PTR [rbp-24]
	mov	rdi, rax
	call	strlen
	mov	QWORD PTR [rbp-8], rax   ; str_len
; la §première§ partie de for() se termine ici
	jmp	.L2
; le corps de for() commence ici
.L5:
	cmp	BYTE PTR [rbp-9], 13     ; c=='\r'?
	je	.L3
	cmp	BYTE PTR [rbp-9], 10     ; c=='\n'?
	jne	.L4
.L3:
	mov	rax, QWORD PTR [rbp-8]   ; str_len
	lea	rdx, [rax-1]             ; EDX=str_len-1
	mov	rax, QWORD PTR [rbp-24]  ; s
	add	rax, rdx                 ; RAX=s+str_len-1
	mov	BYTE PTR [rax], 0        ; s[str_len-1]=0
; le corps de for() se termine ici
; la §troisième§ partie de for() commence ici
	sub	QWORD PTR [rbp-8], 1     ; str_len--
; la §troisième§ partie de for() se termine ici
.L2:
; la §deuxième§ partie de for() commence ici
	cmp	QWORD PTR [rbp-8], 0     ; str_len==0?
	je	.L4                      ; alors sortir
; tester la seconde clause, et charger "c"
	mov	rax, QWORD PTR [rbp-8]   ; RAX=str_len
	lea	rdx, [rax-1]             ; RDX=str_len-1
	mov	rax, QWORD PTR [rbp-24]  ; RAX=s
	add	rax, rdx                 ; RAX=s+str_len-1
	movzx	eax, BYTE PTR [rax]  ; AL=s[str_len-1]
	mov	BYTE PTR [rbp-9], al     ; stocker l §caractère chargé§ dans "c"
	cmp	BYTE PTR [rbp-9], 0      ; est-ce §zéro§?
	jne	.L5                      ; oui? alors sortir
; la §deuxième§ partie de for() se termine ici
.L4:
; renvoyer "s"
	mov	rax, QWORD PTR [rbp-24]
	leave
	ret
