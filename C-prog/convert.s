	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 15, 6	sdk_version 10, 15, 6
	.globl	_AddTwo                 ## -- Begin function AddTwo
	.p2align	4, 0x90
_AddTwo:                                ## @AddTwo
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	addl	-8(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_SubTwo                 ## -- Begin function SubTwo
	.p2align	4, 0x90
_SubTwo:                                ## @SubTwo
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-8(%rbp), %eax
	subl	-4(%rbp), %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$2, -8(%rbp)
	movl	$3, -12(%rbp)
	movl	$0, -16(%rbp)
	cmpl	$0, -16(%rbp)
	jne	LBB2_2
## %bb.1:
	movl	-8(%rbp), %edi
	movl	-12(%rbp), %esi
	callq	_AddTwo
	movslq	%eax, %rdi
	movb	$0, %al
	callq	_printf
	jmp	LBB2_5
LBB2_2:
	cmpl	$1, -16(%rbp)
	jne	LBB2_4
## %bb.3:
	movl	-8(%rbp), %edi
	movl	-12(%rbp), %esi
	callq	_SubTwo
	movslq	%eax, %rdi
	movb	$0, %al
	callq	_printf
LBB2_4:
	jmp	LBB2_5
LBB2_5:
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
