.data

	message: .asciiz  "Your Age is:"
	prompt:  .asciiz  "Enter Your Age: "
	
.text

	# Promt the user to enter age
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Get the user's age
	li $v0, 5
	syscall
	
	# Move to content of $v0 to $t0
	move $t0, $v0
	
	# Display the age
	li $v0, 4
	la $a0, message
	syscall 
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall 
	

	
	