# Group No. 54
# Assignment: 6
# Problem : 1
# Name : Avijit Mandal
# Roll No. : 18CS30010
# Name : Sumit Kumar Yadav
# Roll No.: 18CS30042 

##########Data Segment########################
.data
	input1:	.asciiz "Enter first number : "
	input2:	.asciiz "Enter second number : "
	output:	.asciiz "GCD of given two numbers is : "
	error:	.asciiz "Invalid input(i.e, Entered number is not positive)"
	newline:  .asciiz "\n"

###########Code Segment#####################	
.text
	main:
		#user to input first number
		li $v0,4
		la $a0,input1
		syscall
		
		#get input first number
		li $v0,5
		syscall
		
		#store value of first number in t0
		move $t0,$v0
		
		#user to input second number
		li $v0,4
		la $a0,input2
		syscall
		
		#get input second number
		li $v0,5
		syscall
		
		#store value of second number in t1
		move $t1,$v0
		
		#sanity checking to ensure that both number are positive
		blt $t0,1,error_display
		blt $t1,1,error_display
		j gcd
		
	error_display:			#entered numbers are not positive
		li $v0,4
		la $a0,error
		syscall
		j exit			# jump to end label
		
	gcd:
		#GCD calculation, t0 is 1st number say a and t1 is 2nd number say b
		bgt $t0,$t1,a_greater_b		# a>b jump to label a_greater_b
		j b_greater_a			# otherwise b_greater_a
	
	a_greater_b:
		sub $t0,$t0,$t1		
		j check
	
	b_greater_a:
		sub $t1,$t1,$t0
		j check
	
	check:
		bgt $t1,$zero,gcd		# if $t1=0 then end gcd loop 
		
		li $v0,4			#print newline
		la $a0,newline
		syscall
		
		li $v0,4			#print the gcd of number
		la $a0,output
		syscall
		 
		li $v0,1			# end the program
		move $a0,$t0
		syscall 
		
	exit:
		#end the program
		li $v0,4
		la $a0,newline
		syscall
		
		li $v0,10
		syscall
		
		
