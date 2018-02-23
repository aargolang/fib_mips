.text

main:

li $a0, 6		# load 5 into argument register
jal FIB			# run fib(int)

li $v0, 10		# end program
syscall			# end program

FIB:

# base case

bgt $a0, 1, FIBRECURSE	# branch to fibrecurse if argument is greater than 1
li $v0, 1		# return 1
jr $ra

# recursive step

FIBRECURSE:
addi $sp, $sp, -8	# move stack pointer down 8 bytes
sw $a0, 0($sp)		# store argument value on stack
sw $ra, 4($sp)		# store return address on stack

addi $a0, $a0, -1	# set argument to n-1
jal FIB			# get fib(n-1) into v0

addi $sp, $sp, -4	# move stack pointer down 4 bytes
sw $v0, 0($sp)		# store fib(n-1) to stack

addi $a0, $a0, -1	# set argument to n-2
jal FIB			# get fib(n-2) into v0

move $t0, $v0		# store value of fib(n-2) into t0

lw $v0, 0($sp)		# recover fib(n-1) from stack
addi $sp, $sp, 4		# move stack pointer up 4 bytes

add $v0, $t0, $v0	# add fib(n-1) + fib(n-2) and store in return-value v0

lw $ra, 4($sp)		# revocer return address from stack
lw $a0, 0($sp)		# recover argument from stack
addi $sp, $sp, 8		# move stack pointer up 8 bytes

jr $ra