# Tyler Moses on 02/04/2018
# altfib.s is a function for the reverse fibbonacci sequence
# 1 -1 2 -3 5 -8 13
# 1 -1 then n = (n-2) - (n-1) for n > 2
##########################
# ALTFIB Function
##########################
ALTFIB:
	li $a0, 1					# fib(0) = 1
	li	$v0, 1					# print this
    syscall

    la $a0, spc					# print space
    li $v0, 4
    syscall

    li $a0, -1					# fib(1) = -1
    li	$v0, 1					# print this
    syscall

    la $a0, spc					# print space
    li $v0, 4
    syscall

	li $a0, 1					# fib(0) = 1
    li $a1, -1					# fib(1) = -1
    li $a2, 2					# space counter
    li $a3, 0
##########################
# ALTFIBLOOP Function
##########################
ALTFIBLOOP:
	beq $a2, 5, PRINTNEWLINE
	slti $t0, $a3, 10			# check a2 < 10
    beq $t0, $zero, EXIT		# EXIT

	sub $a0, $a0, $a1			# fib(n) = fib(n-2) - fib(n-1)
	li	$v0, 1					#
    syscall

	move $t0, $a0

	la $a0, spc					# print space
    li $v0, 4
    syscall

	move $a0, $a1
	move $a1, $t0

ADDLOOP:
	addi $a2, $a2, 1			# $a2 += 1
	addi $a3, $a3, 1
    j ALTFIBLOOP
##########################
# RESETSPACECOUNTER Function
##########################
PRINTNEWLINE:
	addi	$sp, $sp, -4		# adjust stack for 2 items
    sw	$a0, 0($sp)				# save the argument n

	la	$a0, newl		    	# display welcome message
    li	$v0, 4
    syscall

    lw	$a0, 0($sp)				# return from jal: restore argument n
    addi	$sp, $sp, 4			# adjust stack pointer to pop 2 items

	add $a2, $zero, $zero		# Rest Prints

    j ADDLOOP
##########################
# EXIT Function
##########################
EXIT:
	move $t0, $a0				# Save input

	la	$a0, rese				# Print result message
	li	$v0, 4
    syscall

	add $a0, $zero, $t0			# Print input

	li $v0,10					# End program
    syscall
##########################
# main Function
##########################
main:
	la	$a0, welc		    	# display welcome message
    li	$v0, 4
    syscall

    j ALTFIB					# Call ALTFIB

	.data
welc:	.asciiz "Here are the alternating Fibonacci numbers that I produced:\n\n"
newl:	.asciiz "\n"
rese:	.asciiz "\n\nValue causing overflow = "
spc:	.asciiz " "
