	.file	"c1.c"
	.text
	.section	.rodata
.LC0:
	.string	"\nThe greater number is: %d"
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
	subq	$16, %rsp        /*allocating space of 16 bits */
	movl	$45, -8(%rbp)    /* num1=45                     */
	movl	$68, -4(%rbp)    /* num2=68 */
	movl	-8(%rbp), %eax   /* eax=num1 */
	cmpl	-4(%rbp), %eax   /* (num1 - num2) */
	jle	.L2              /* if (num1-num2)<=0 jump to .L2 */
	movl	-8(%rbp), %eax   /* eax = num1 */
	movl	%eax, -12(%rbp)  /* greater = eax */
	jmp	.L3              /* jump to .L3 without any condition */
.L2:
	movl	-4(%rbp), %eax   /* eax = num2 */
	movl	%eax, -12(%rbp)  /* greater = eax */
.L3:
	movl	-12(%rbp), %eax  /* eax = greater */
	movl	%eax, %esi       /* esi = eax --> the second arguement for printf */
	leaq	.LC0(%rip), %rdi /* rdi = .LC0 --> the first arguement for printf */
	movl	$0, %eax        
	call	printf@PLT       /* printf ("\nThe greater number is: %d", greater); */
	movl	$0, %eax         /* eax = 0 --> return value stored */
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
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
