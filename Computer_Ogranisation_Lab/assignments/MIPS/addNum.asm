.data

.text

	main:
		
		# By convention $a0, $a1, $a2, $a3 used for passing arguments
		addi $a1, $zero, 50
		addi $a2, $zero, 100 
		
		jal addNum
		
		li $v0, 1
		move $a0, $v1
		syscall
		
	# Tell to exit the programme
	li $v0, 10
	syscall
	
	addNum:
		add $v1, $a1, $a2 
		# by convenction $v1 is passed  and return
		
		jr $ra