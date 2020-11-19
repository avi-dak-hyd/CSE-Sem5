# Group No. 54

# Assignment: 7

# Problem : 3

# Name : Avijit Mandal

# Roll No. : 18CS30010

# Name : Sumit Kumar Yadav

# Roll No.: 18CS30042



##########Data Segment########################

.data

	input: .asciiz "Enter 9 numbers : "

	sorted_array: .asciiz "Array in ascending order is : "

	key_input: .asciiz "Enter the key :"

	error: .asciiz "Number not found!\n"

        found: .asciiz "Number found at index: "

	white: .asciiz " "

	.align 2

	array: .space 36

	newline:  .asciiz "\n"



###########Code Segment#####################

.text

	main:

		#user to input 9 numbers

		li $v0, 4

		la $a0, input

		syscall



		li $v0,4			#print newline

		la $a0,newline

		syscall

			

		li $t1,1  			#initializing t1(i) = 1

		la $t3, array			#loading address of array in t3



		input_array: 			#Loop to take input from the user



	        	li $v0, 5 		#read in user input

	        	syscall



	        	move $t0, $v0 		#moving input value to t0



	        	addi $t1, $t1, 1 	#increasing t1(i) by 1



	        	sw $t0,($t3) 		#storing entered value at array[i]

	        	addi $t3,$t3,4 	#increasing address of t3 to access next address



	        	bne  $t1,10,input_array #get user input up to 9 times



	    	li $a0, 9 			#set count arg (length of array)

		la $a1, array 		   	#load address of array in a1 

		li $t0, 0

		jal insertion_sort		#jump to the insertion_sort label





		insertion_sort:				

			beq $t0, $a0, bin_pre 	        #Check if loop has run 9 times

			move $t1, $t0 			#t1=t0

			move $t2, $a1			#assigning current address to t2

			move $t3, $a1

			jal sorting_loop		#jump to the sorting_loop label





		sorting_loop: 			

			beq $t1, $a0, swap_value 		#if inner loop has reached last position



			lw $t5, ($t2) 				#load current max

			lw $t6, ($t3) 				#load current value



			blt $t5, $t6 , store 			#if t5 < t6 store, ascending order 



			addi $t2, $t2, 4 			#increase t2

			addi $t1, $t1, 1 			#increase inner loop

			j sorting_loop				#jump to the sorting_loop label



		store:

			move $t3, $t2 				#store address of numbers to be exchanged

			

			addi $t2, $t2, 4 			#increase t2

			addi $t1, $t1, 1 			#increase innerloop

			j sorting_loop				#jump to the sorting_loop label

							



		swap_value: 

			lw  $t5, ($a1) 			# t5 = (a1)

			lw  $t6, ($t3)				# t6 = (t3) 

			sw  $t6, ($a1) 			# (a1) = t6

			sw  $t5, ($t3) 			# (t3) = t5

			addi $t0, $t0, 1			#increase outer loop

			addi $a1, $a1, 4			#increase a1 by 4

			j insertion_sort		#jump to the insertion_sort label



		bin_pre:

			la $a0, key_input

			li $v0, 4

			syscall

			

			li $v0, 5

			syscall

			add $t7, $zero, $v0

			

			la $s0, array

			add $t0, $zero, $zero

			addi $t1, $t0, 8

			

			j Binary_search

			

		Binary_search:

			bgt $t0, $t1, not_found

			



	    		add $t2, $t1, $t0

	    		srl $t2, $t2, 1



	    		sll $t5, $t2, 2

	    		add $t5, $t5, $s0



	    		lw $t4, ($t5)



	    		beq $t4, $t7, equal

	    		bgt $t4, $t7, shiftleft

	    		bgt $t7, $t4, shiftright

	    		

	    	j exit

			

		not_found:

			la $a0, error

			li $v0,4

			syscall

			

			j exit

			

		shiftleft:

	   		addi $t1, $t2, -1

	   		j Binary_search



	   	shiftright:

	   		addi $t0, $t2, 1

	   		j Binary_search



	   	equal:

	   		la $a0, found

			li $v0, 4

			syscall



			li $v0, 1

	        	move $a0, $t2

			syscall



			j exit



		

		exit: 

			li $v0, 10  				# end the program

			syscall 