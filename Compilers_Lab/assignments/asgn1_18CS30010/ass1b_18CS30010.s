	.file	"c1.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"\nGCD of %d, %d, %d and %d is: %d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp      		/* creating space for local variables */
	movl	$45, -20(%rbp) 		/* a = 45 ; */
	movl	$99, -16(%rbp) 		/* b = 99 ; */
	movl	$18, -12(%rbp) 		/* c = 18 ; */
	movl	$180, -8(%rbp) 		/* d = 180 ; */
	movl	-8(%rbp), %ecx 		/* ecx = d --> 4th arguement for GCD4 */
	movl	-12(%rbp), %edx		/* edx = c --> 3rd arguement for GCD4 */
	movl	-16(%rbp), %esi		/* esi = b --> 2nd arguement for GCD4 */
	movl	-20(%rbp), %eax		/* eax = a  */
	movl	%eax, %edi			/* edi = eax --> 1st arguement for GCD4  */
	call	GCD4  				/* calling GCD4  */
	movl	%eax, -4(%rbp)		        /* result = eax   --> return value of last called function  */
	movl	-4(%rbp), %edi                 /* edi = result  */
	movl	-8(%rbp), %esi			/* esi = d  */
	movl	-12(%rbp), %ecx		/* ecx = c  */
	movl	-16(%rbp), %edx		/* edx = b */
	movl	-20(%rbp), %eax		/* eax = a		 -->> in this block (26-33) the argument for printf is populated  */
	movl	%edi, %r9d			/* r9d = result  */
	movl	%esi, %r8d			/* r8d = d */
	movl	%eax, %esi			/* esi = a */
	leaq	.LC0(%rip), %rdi		/* populating "rdi" the first arguement with .LC0 content  */
	movl	$0, %eax
	call	printf@PLT			/* calling printf  */
	movl	$10, %edi
	call	putchar@PLT
	movl	$0, %eax			/* returning value is populated ,i.e eax=0  */
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	GCD4
	.type	GCD4, @function
GCD4:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp			/* making space for local varibles t1,t2,t3  */
	movl	%edi, -20(%rbp)		/* pushing n1 */
	movl	%esi, -24(%rbp)		/* pushing n2 */
	movl	%edx, -28(%rbp)		/* pushing n3 */
	movl	%ecx, -32(%rbp)		/* pushing n4 */
	movl	-24(%rbp), %edx     /* edx = n2 */
	movl	-20(%rbp), %eax		/* eax = n1 */
	movl	%edx, %esi			/* putting edx in first arguement for GCD --> esi = edx   */
	movl	%eax, %edi			/* putting eax in second arguement for GCD --> edi = eax */
	call	GCD
	movl	%eax, -12(%rbp) 	/* t1 = eax --> return value from last GCD call  */
	movl	-32(%rbp), %edx     /* edx = n4 */
	movl	-28(%rbp), %eax		/* eax = n3 */
	movl	%edx, %esi			/* putting edx in first arguement for GCD --> esi = edx  */
	movl	%eax, %edi			/* putting eax in second arguement for GCD --> edi = eax */
	call	GCD
	movl	%eax, -8(%rbp)		/* t2 = eax --> return value from last GCD call  */
	movl	-8(%rbp), %edx		/* edx = t2  */
	movl	-12(%rbp), %eax		/* eax = t1  */
	movl	%edx, %esi			/* putting edx in first arguement for GCD --> esi = edx  */
	movl	%eax, %edi			/* putting eax in second arguement for GCD --> edi = eax  */
	call	GCD
	movl	%eax, -4(%rbp)		/* t3 = eax --> return value from last GCD call  */
	movl	-4(%rbp), %eax		/* eax = t3 --> return value stored in eax  */
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	GCD4, .-GCD4
	.globl	GCD
	.type	GCD, @function
GCD:
.LFB2:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -20(%rbp)		/* edi is stored in the content of rbp - 20 ( num1 )  */
	movl	%esi, -24(%rbp)     /* esi is stored in the context pf rbp - 24 ( num2 )  */
	jmp	.L6	
.L7:
	movl	-20(%rbp), %eax		/* eax = Mem[rbp-20] or eax stores num1  */
	cltd
	idivl	-24(%rbp)           /* edx = eax % Mem[rbp-24]  */
	movl	%edx, -4(%rbp)		/* Mem[rbp-4] = edx  -- or you can say temp = edx --  */
	movl	-24(%rbp), %eax		/* eax = Mem[rbp - 24] -- or -- eax = num2   */
	movl	%eax, -20(%rbp)		/* Mem[rbp - 20] = eax -- or -- num1 = num2  */
	movl	-4(%rbp), %eax      /* eax = temp  */
	movl	%eax, -24(%rbp)     /* num2 = temp */
.L6:
	movl	-20(%rbp), %eax		/* eax = context of rbp - 20, i.e num1  */
	cltd						/* converts signed long to signed double long  */
	idivl	-24(%rbp)			/* edx = eax % Mem[rbp-24]  */
	movl	%edx, %eax			/* eax = edx  */
	testl	%eax, %eax			/* eax Not Zero  */ 
	jne	.L7						/* Not Zero then jump to .L7  */
	movl	-24(%rbp), %eax		/* populating the return reg */
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	GCD, .-GCD
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
