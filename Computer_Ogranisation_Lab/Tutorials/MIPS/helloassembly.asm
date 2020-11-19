.data
	
  
.text

	addi $s0, $zero, 10
	addi $s1, $zero, 4
	
	mul $t0, $s1, $s0    # You can multiply only 16 bits as 
	
	li $v0, 1
	add $a0 , $zero, $t0
	syscall 
	
	