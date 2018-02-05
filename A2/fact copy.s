	.text
fact:	slti	$t0, $a0, 1		# test for n < 1
	beq	$t0, $zero, L1	# if n >= 1, go to L1

	li	$v0, 1		# return 1
	jr	$ra		# return to instruction after jal

L1:	addi	$sp, $sp, -8	# adjust stack for 2 items
	sw	$ra, 4($sp)	# save the return address
	sw	$a0, 0($sp)	# save the argument n

	addi	$a0, $a0, -1	# n >= 1; argument gets (n – 1)
	jal	fact		# call fact with (n – 1)

	lw	$a0, 0($sp)	# return from jal: restore argument n
	lw	$ra, 4($sp)	# restore the return address
	addi	$sp, $sp, 8	# adjust stack pointer to pop 2 items

	mul	$v0, $a0, $v0	# return n * fact (n – 1)

	jr	$ra		# return to the caller

main:
	la	$a0, welcome	# display welcome message


	.data
welcome:	.asciiz	"Welcome to the factorial tester!"
question:	.asciiz "Enter a value for n (or a negative value to exit): " 
