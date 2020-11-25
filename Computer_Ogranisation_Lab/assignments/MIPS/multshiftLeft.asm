.data

.text

	addi $t2, $zero, 2
	

	sll $t1, $t2, 2
	
	li $v0, 1
	move $a0, $t1
	syscall