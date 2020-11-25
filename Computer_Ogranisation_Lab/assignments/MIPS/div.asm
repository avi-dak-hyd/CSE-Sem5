.data


.text
	
	addi $t0, $zero, 21
	addi $t1, $zero, 5
	
	div $t2, $t0, 10
	li $v0, 1
	move $a0, $t2
	syscall