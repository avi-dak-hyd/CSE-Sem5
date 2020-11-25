# Group No. 54
# Assignment: 6
# Problem : 2
# Name : Avijit Mandal
# Roll No. : 18CS30010
# Name : Sumit Kumar Yadav
# Roll No.: 18CS30042

##########Data Segment########################
.data
	message1: .asciiz "Enter Number : "
	message2: .asciiz "Entered number is Prime number"
	message3: .asciiz "Entered number is Composite number"
	error:    .asciiz "Invalid input (Error: The Number is less than 2)"
	newline:  .asciiz "\n"

###########Code Segment#####################	
.text

	main:
		# user to input first number
		li $v0, 4
		la $a0, message1
		syscall
		
		# Taking input in $v0
		li $v0, 5
	        syscall
	        
	        # Storing it in $t0
	        add $t0, $zero, $v0
	        
	        blt $t0, 2, displayError
	        
	        # If n==2 then print it is prime
	        
	        beq $t0, 2, displayPrime
	        
	        add $t1, $zero, 2 	# set i=2
	        
	        while:
	        
	        	add $s0, $t0, -1		
	        	bgt $t1, $s0, exit
	        	
	        	div $t0, $t1
	        	mfhi $t2
	        	beqz $t2, displayNotPrime
	        	
	        	addi $t1, $t1, 1
	        	j while
	        
	        exit:
	        	b displayPrime
	        
	
	# Exit the Program
	li $v0, 10
	syscall
	
	displayError:
	
		# display the error
		li $v0, 4
		la $a0, error
		syscall
		
		# new line
		li $v0,4
		la $a0,newline
		syscall
		
		# end the program
		li $v0, 10
		syscall
		
	displayPrime:
		# display that number is prime
		li $v0, 4
		la $a0, message2
		syscall
		
		# new line
		li $v0,4
		la $a0,newline
		syscall
		
		# end the program
		li $v0, 10
		syscall
		
	displayNotPrime:
		# display that number is composite
		li $v0, 4
		la $a0, message3
		syscall
		
		# new line
		li $v0,4
		la $a0,newline
		syscall
		
		# end the program
		li $v0, 10
		syscall
