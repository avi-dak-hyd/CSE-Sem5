.data
	message: .asciiz "Hi, How are You\n"
.text

	main:
		addi $s0, $zero, 10
		addi $s1, $zero, 10
		
		# if $s0 > $s1
		bgt $s0, $s1, displayHi
		
		# if $s0 < $s1
		blt $s0, $s1, displayHi
		
		
		
	
	# End of main
	li $v0, 10
	syscall
	
	displayHi:
		li $v0, 4
		la $a0, message
		syscall