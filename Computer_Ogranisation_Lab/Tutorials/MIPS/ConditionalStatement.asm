.data

	message: .asciiz "The numbers are not equal\n"
	message2: .asciiz "Nothing Happend\n"
.text

	main:
		addi $t0, $zero, 4
		addi $t1, $zero, 4
		
		bne $t0, $t1, numberDiff
		b numberDiff
		
		
	
	# Exiting the programme
	li $v0, 10
	syscall
	
	numberDiff:
		li $v0, 4
		la $a0, message
		syscall