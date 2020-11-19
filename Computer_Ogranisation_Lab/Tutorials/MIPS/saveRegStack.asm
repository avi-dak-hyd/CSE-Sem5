.data
	newLine: .ascii "\n"
.text
	main:
	
		addi $s0, $zero, 10
		
		jal printTheVal
		
		li $v0, 4
		la $a0, newLine
		syscall
		
		jal increseMyRegister
			
				
		li $v0, 4
		la $a0, newLine
		syscall
			
		jal printTheVal
	
	# Exiting the Programme
	li $v0, 10
	syscall
	
	increseMyRegister:
		addi $sp, $sp, -8
		
		sw $s0, 0($sp)
		sw $ra, 4($sp)
		
		addi $s0, $s0, 30
		
		# Print new value in function
		jal printTheVal
		
		lw $s0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 4
		
		jr $ra
		
	printTheVal:
		li $v0, 1
		move $a0, $s0
		syscall
		
		jr $ra
		
		
		
		
		