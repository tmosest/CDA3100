# Tyler Moses on 02/04/2018
# fact.s � a factorial program
# Register use:
#	$a0 For storing n and the result
#	$v0	syscall parameter
#	$t0-$t1	temporary calculations
#	$s0	the variable n
FACT:
    slti	$t0, $a0, 1		# test for n < 1
	beq	$t0, $zero, L1	# if n >= 1, go to L1

	li	$v0, 1		# return 1
	jr	$ra		# return to instruction after jal

L1:
    addi	$sp, $sp, -8	# adjust stack for 2 items
	sw	$ra, 4($sp)	# save the return address
	sw	$a0, 0($sp)	# save the argument n

	addi	$a0, $a0, -1	# n >= 1; argument gets (n � 1)
	jal	FACT		# call fact with (n � 1)

	lw	$a0, 0($sp)	# return from jal: restore argument n
	lw	$ra, 4($sp)	# restore the return address
	addi	$sp, $sp, 8	# adjust stack pointer to pop 2 items

	mul	$v0, $a0, $v0	# return n * fact (n � 1)

	jr	$ra		# return to the caller

L2:
    la	$a0, prom		    # request a value for n
    li	$v0, 4
    syscall

    li	$v0, 5		        # read value of n
    syscall

    move	$a0, $v0		# save value of n in $a0

    slti	$t0, $a0, 0		# test for n < 0
    bne	$t0, $zero, EXIT	# if n < 0, then exit

    move    $s0, $a0
    li $v0, 1               # system call code 1: print_int
    syscall

    la $a0, answ            # print the rest of the answer text
    li	$v0, 4
    syscall

    move $a0, $s0		    # save value of n in $a0
    jal	FACT	            # invoke fact procedure

    move $a0, $v0           # move result to a0
    li $v0, 1               # system call code 1: print_int
    syscall

    j L2                    # loop again for another question

EXIT:
    la	$a0, clos		    # display close message
    li	$v0, 4
    syscall

    li $v0,10
    syscall

main:
	la	$a0, welc		    # display welcome message
	li	$v0, 4
	syscall

	j L2

	.data
welc:	.asciiz	"Welcome to the factorial tester!"
prom:   .asciiz "\nEnter a value for n (or negative value to exit) : "
answ:   .asciiz "! is "
clos:   .asciiz "back soon!"
