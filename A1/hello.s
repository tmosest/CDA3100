# Tyler O. Moses -- 01/14/2018
# hello.s -- a traditional "Hello World" first program.
# Register uses:
# 	$v0 syscall parameter and return value
#	$a0 syscall parameter

	.text
	.globl	main
main:
	la $a0, msg 	# address of "Hello World" message
	li $v0, 4   	# this is the print_string option
	syscall		# perform the syscall

	li $v0, 10	# this is the exit option
	syscall

# Here is the data for the program
	.data
msg:	.asciiz		"Hello World\n"

# end hello.s
