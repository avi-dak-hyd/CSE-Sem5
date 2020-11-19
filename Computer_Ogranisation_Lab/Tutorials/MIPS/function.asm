#procedure asm or function asm

.data
	message: .ascii "hi everyone\n.My name is Avijit Mandal\n"
.text
	main:
		jal displayMessage # $ra will store the return address
	

		li $v0, 1
		addi $a0, $zero, 5
		syscall
	
	
	#Tell the programme that the programme is done
	li $v0, 10
	syscall
	
	displayMessage:
		li $v0, 4
		la $a0, message
		syscall
		
		jr $ra
