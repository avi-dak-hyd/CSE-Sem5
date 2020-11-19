# Group No. 54
# Assignment: 6
# Problem : 3
# Name : Avijit Mandal
# Roll No. : 18CS30010
# Name : Sumit Kumar Yadav
# Roll No.: 18CS30042

##########Data Segment########################
.data
	message1: .asciiz "Enter first 16 Bit Unsigned Number(decimal form) : "
	message2: .asciiz "Enter second 16 Bit Unsigned Number(decimal form) : "
	error:    .asciiz "Entered Number is Not Valid (Please enter 16 Bit Unsigned number)"
	success: .asciiz "The Multiplication of given 2 numbers is : "
	newline:  .asciiz "\n"
	
###########Code Segment#####################	
.text

	main:
		# User to input first number
		li $v0, 4
		la $a0, message1
		syscall
		
		# read number 1
		li $v0, 5
		syscall
		
		# store input number in s0
		add $s0, $zero, $v0
		
		# valid range is [0,2^16-1]
		#sanity checking
		bge $s0, 65536, displayError  	 # where 2^16 =65536 so error display when number is greater or equal to 2^16
		blt $s0, $zero,  displayError

		# User to input number 2
		li $v0, 4
		la $a0, message2
		syscall
		
		# read number 2
		li $v0, 5
		syscall
			
		# store input number in s1
		add $s1, $zero, $v0	
		
		# valid range is [0,2^16-1]
		#sanity checking
		bge $s1, 65536, displayError  # where 2^16 =65536 so error display when number is greater or equal to 2^16
		blt $s1, $zero,  displayError
		
		
		# Giving Arquements
		add $a1, $zero, $s0
		add $a2, $zero, $s1
		
		li $v0, 4
		la $a0, success
		syscall
				
		jal seq_mult_unsigned  # jump to label seq_mult_unsigned
		
		# output the result
		li $v0, 1
		move $a0, $v1
		syscall
		
		# new line
		li $v0,4
		la $a0,newline
		syscall
	
	
		# Exiting The Programme
		li $v0, 10
		syscall
	
	displayError:
		# display error message
		li $v0, 4
		la $a0, error
		syscall
		
		# new line
		li $v0,4
		la $a0,newline
		syscall
		
		# end program
		li $v0, 10
		syscall
	
	seq_mult_unsigned:
	
		add $v1, $zero, $zero		# initialize v1 =0
		add $t1, $zero, $zero 		# initialize t1 =0
		
		while:
			bgt $t1, 15, exit     # while $t1 <= 15
			
			addi $t2, $zero, 1    # $t2 = 1 
			sllv $t3, $t2, $t1    # $t3 = 1LL << $t1
			and $t5, $a2, $t3     # $t5 = $a2 & (1LL << $t1)
			
			sllv $t4, $a1, $t1    # $t4 = $a1 << $t1
			
			addi $t1, $t1, 1      # $t1 = $t1 + 1
			
			beqz $t5, while
			
			add $v1, $v1, $t4
			
			b while
		
		exit:
			jr $ra		# return
		
	

