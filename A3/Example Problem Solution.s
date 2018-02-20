# Stephen P. Leach -- 03/10/12
# Example Problem Solution.s - functions that produce the sum m+(m+1)+..+n   
#	The integer values of m and n are input by the user.  
#	If n < m, output the value 0.

# Function Summit --- written by Stephen P. Leach -- 03/10/12
#	Calculate the sum m + (m+1) + ... + n utilizing the auxiliary
#	function Formula which calculates 1 + 2 + ... + x.  Return this
#	sum.  It is assumed that m is positive. If n < m, return 0. 
# Register use:
#	$a0	integer parameter m from calling routine and 
#		parameter x for function Formula
#	$a1	integer parameter n from calling routine
#	$v0	return value from function Formula and value returned
#		to calling routine
#	$s0	saved value of m
#	$s1	saved value of Formula(n)

Summit:	blt	$a1, $a0, zip		# quick exit if n < m
	addi	$sp, $sp, -12		# save $ra,$s0,$s1 on stack	
	sw	$ra, 8($sp)
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)

	move	$s0, $a0		# save m in $s0

	move	$a0, $a1		# compute 1+2+...+n
	jal	Formula	
	move	$s1, $v0		# and save in $s1

	addi	$a0, $s0, -1		# compute 1+2+...(m-1)
	jal	Formula

	sub	$v0, $s1, $v0		# compute final result

	lw	$s0, 0($sp)		# restore values from stack
	lw	$s1, 4($sp)
	lw	$ra, 8($sp)
	addi	$sp, $sp, 12

	jr	$ra			# and return to calling routine

zip:	li	$v0, 0			# quick exit
	jr	$ra
	 

# function Formula -- written by Stephen P. Leach -- 03/10/12
#	Given the value of x (in $a0), this function computes
#	and returns (in $v0) the value 1+2+...+n
# Register use:
#	$a0	the value x 
#	$v0	return value (1+2+...+x)

Formula:
	addi	$v0, $a0, 1		# x + 1
	mul	$v0, $v0, $a0		# times x
	li	$t0, 2
	div	$v0, $v0, $t0		# divided by 2

	jr	$ra			# return to calling routine


# Driver program provided by Stephen P. Leach -- written 03/10/12
# Register use:
#	$s0	the value of m
#	$s1	the value of n
#	$s2	the value of the sum [m+(m+1)+..+n]

main:	la	$a0, intr		# print intro
	li	$v0, 4
	syscall

next:	la	$a0, reqm		# request value of m
	li	$v0, 4
	syscall

	li	$v0, 5			# read value of m
	syscall

	ble	$v0, $zero, out		# if m is 0 or negative, exit

	move	$s0, $v0		# save value of m in $s0

	la	$a0, reqn		# request value of n
	li	$v0, 4
	syscall

	li	$v0, 5			# read value of n
	syscall

	move	$s1, $v0		# save value of n

	move	$a0, $s0		# set parameter m for Summit function
	move	$a1, $v0		# set parameter n for Summit function

	jal	Summit			# invoke Summit function

	move	$s2, $v0		# save answer

	la	$a0, txt1		# display answer (txt1)
	li	$v0, 4
	syscall

	move	$a0, $s0		# display m
	li	$v0, 1
	syscall

	la	$a0, txt2		# display answer (txt2)
	li	$v0, 4
	syscall

	move	$a0, $s1		# display n
	li	$v0, 1
	syscall

	la	$a0, txt3		# display answer (txt3)
	li	$v0, 4
	syscall

	move	$a0, $s2		# display answer (value)
	li	$v0, 1
	syscall

	j	next			# branch back for next value of m

out:	la	$a0, done		# display closing
	li	$v0, 4
	syscall

	li	$v0, 10		# exit from the program
	syscall


	.data
intr:	.asciiz  "Welcome to the Example Problem tester!"
reqm:	.asciiz  "\nEnter a value for m (0 or negative to exit): "
reqn:	.asciiz  "Enter a value for n: "
txt1:	.asciiz  "The sum of the numbers from "
txt2:	.asciiz  " to "
txt3:	.asciiz  " is "
done:	.asciiz  "Come back soon!\n"

