.data
Input1:			.asciiz "\nFirst Input " 
Input2: 		.asciiz "\nSecond Input "
HighestNumber: 	.asciiz "\nThe larger number "
Sum:			.asciiz "\na+b="
FirstSubtract:		.asciiz "\na-b="
SecondSubtract:	.asciiz "\nb-a="
Mult:			.asciiz "\na*b= "
Divide:			.asciiz "\na/b "
Error:			.asciiz "\nError "

.text
main:
	li $v0,4 #load imeditaely, service 4 print string
	la $a0, Input1  #load address with la 
	#Print String with la $a0, string
	syscall
	
	li $v0, 5 #read interger with serivce 5
	syscall
	move $s1, $v0 #Copy s0 to s1
	
	
	li $v0,4
	la $a0, Input2 #Print String
	syscall
	
	li $v0,5
	syscall
	move $s2, $v0 
	
	li $v0,4
	la $a0, HighestNumber
	syscall
	
	bgt $s1, $s2, Output #gt $t1,$t2,label  Branch if Greater Than : Branch to statement at label if $t1 is greater than $t2
	
	move $a0, $s2 
	li $v0, 1 #print interger with service 1
	syscall
	j continue

Output:
	move $a0, $s1 
	li $v0, 1 
	syscall

continue:
#Sum
	li $v0,4
	la $a0, Sum #Pring string
	syscall
	
	add $t0, $s1, $s2 #adding 2 numbers to $t0 
	move $a0, $t0 #$a0 = integer to print
	li $v0, 1
	syscall
	
#Minus

	li $v0, 4
	la $a0, FirstSubtract
	syscall
	
	sub $t0, $s1, $s2
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, SecondSubtract
	syscall
	
	sub $t0, $s2, $s1
	move $a0, $t0
	li $v0,1
	syscall
	
#Multiply
	li $v0, 4
	la $a0, Mult
	syscall
	
	mult $s1, $s2
	mflo $t0 #mflo $t1 Move from LO register : Set $t1 to contents of LO (see multiply and divide operations)
	move $a0, $t0
	li $v0, 1
	syscall

#Divide 
	beqz $s2,error
	
	li $v0,4
	la $a0, Divide
	syscall
	
	div $s1, $s2
	mflo $t0
	move $a0, $t0
	li $v0, 1
	syscall
	j exit
	
error:
	li $v0,4
	la $a0, Error #Print String
	syscall
exit:
	li $v0, 10
	syscall
