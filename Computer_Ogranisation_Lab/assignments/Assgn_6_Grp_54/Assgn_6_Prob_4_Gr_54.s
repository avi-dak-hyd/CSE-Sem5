# Group No. 54
# Assignment: 6
# Problem : 4
# Name : Avijit Mandal
# Roll No. : 18CS30010
# Name : Sumit Kumar Yadav
# Roll No.: 18CS30042

##########Data Segment########################
.data
	input1: .asciiz "Enter first number : "
        input2: .asciiz "Enter second number : "
     	error: .asciiz "Invalid input (Number is out of 16-bit signed integer range)"
      	output: .asciiz "The product of given 2 numbers using booth's algo : "
      	newline:  .asciiz "\n"

###########Code Segment#####################    
.text
	main:
		# user to input first number
		li $v0,4
    		la $a0,input1
    		syscall
    		
    		# get input first number
    		li $v0,5
    		syscall
    		
    		# store value of first number in t0
    		move $t0,$v0
    		
    		# user to input second number
		li $v0,4
    		la $a0,input2
    		syscall
    		
    		# get input second number
    		li $v0,5
    		syscall
    		
    		# store value of second number in t1
    		move $t1,$v0

	    	# valid range is [-2^15 , 2^15-1]   if number is not found in this range error display.
    		#sanity checking
    		addi $t3,$zero,2		# initialize t3=2
    		sll  $t3,$t3,15			# calculate power(2,15) i.e, t3=2^15
    		sub  $t3,$t3,1                  # t3=t3-1
    		slt  $t4,$t3,$t0                # if t3<t0 assign t4=1
    		bne  $t4,$zero,error_display               # if t4!=0 goto error_display
    		slt  $t4,$t3,$t1                # if  t3<t1 assign t4=1
    		bne  $t4,$zero,error_display               # if t4!=0 goto error_display
    
    		addi $t3,$zero,-32768        	# where -2^15 =32768 
    		slt  $t4,$t0,$t3                # if t0<t3 assign t4=1
    		bne  $t4,$zero,error_display               # if t4!=0 goto error_display
    		slt  $t4,$t1,$t3                # if t1<t3 assign t4=1
    		bne  $t4,$zero,error_display               # if t4!=0 goto error_display
    		
    		j product		# jump to the booth algo

   	error_display:
        	#printing error
        	li   $v0,4
        	la   $a0, error
        	syscall

		#new line
        	li $v0,4
        	la $a0,newline

        	j exit			# jump to exit label

    	product:
    		# print output display message
    		li $v0,4
        	la $a0, output
        	syscall

   		# Calling seq_mult_booth
    		move $a0, $t1
    		move $a1, $t0 
    		jal seq_mult_booth             
   
   		#output product value
        	move $a0,$v0
    		li $v0,1
    		syscall

		#new line
    		li $v0,4
        	la $a0,newline
    
    		# end program
    		li $v0,10
        	syscall
        
	seq_mult_booth:
    		addi  $sp, $sp, -32       # create stack to store 8 items i.e,8*4=32
    		sw    $ra, 0($sp)         # return address
    		sw    $a0, 4($sp)         # storing a in the stack
    		sw    $a1, 8($sp)         # storing b in the stack
    		sw    $zero, 12($sp)      # storing res=0 in the stack
    		sw    $zero,16($sp)       # storing x0=0 in the stack
    		add   $t2,$zero,$zero     # initialize i=0
    	loop:
        	slti  $t1,$t2,32          	# if t2>=32 assign t1=0
        	beq   $t1, $zero, end_algo   	# if t1= zero then end_algo
        
        	andi  $t1,$a0,1           	# calculate bitwise AND t1=a & 1

        	lw    $t0, 16($sp)        	# load t0 from stack
        	bne   $t0, $zero, label_1      	# if t0!=0 goto label_1
        	beq   $t1, $zero, label_1      	# if t1 =0 goto label_1
        	lw    $t3, 12($sp)        	# storing res in t3
        	sub   $t3, $t3, $a1       	# assign t3 = t3 - a1
        	sw    $t3, 12($sp)        	# storing res in stack 
        	j label_2			# jump to the label_2
    	label_1:
        	beq   $t0,$zero, label_2	# if t0=0 goto label_2
        	bne   $t1, $zero, label_2	# if t1!=0 goto label_2
        	lw    $t3, 12($sp)        	# load res from stack
        	add   $t3, $t3, $a1       	# assign t3 = t3 + a1
        	sw    $t3, 12($sp)        	# storing res in stack
    	label_2:
        	sw    $t1, 16($sp)        	
        	addi  $t2, $t2, 1         	# increment, i=i+1
        	sll   $a1,$a1,1           	# assign, b=b<<1
        	srl   $a0,$a0,1           	# assign, a=a>>1
        	j loop				# jump to the loop label
    	end_algo:
        	lw    $a0, 4($sp)         # restoring original value of a
        	lw    $a1, 8($sp)         # restoring original value of b
        	lw    $ra, 0($sp)         # restoring ra from stack
        	lw    $v0, 12($sp)        # load res from stack to v0
        	addi  $sp, $sp, 32        # restoring stack pointer
        	jr    $ra                 # jump to return address
    
    	exit:
        	li $v0,10
        	syscall