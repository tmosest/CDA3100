# Tyler Moses on 02/04/2018
# altfib.s is a function for the reverse fibbonacci sequence
# 1 -1 2 -3 5 -8 13
# 1 -1 then n = (n-2) - (n-1) for n > 2
##########################
# ALTFIB Function
##########################
	.text
main:
	la	$a0, welc		    # display welcome message
    li	$v0, 4
    syscall

    j expdriver

expdriver:
	la	$a0, menu		    # ask for input
    li	$v0, 4
    syscall

    li	$v0, 7		        # read value of x as double
    syscall

	l.d $f12, check			# $f12 = 999

	c.eq.d $f0, $f12		# is x == 999 ?
    bc1t exit				# then exit
	nop

    la	$a0, res		    # display result message
    li	$v0, 4
    syscall

    li $v0, 3				# display input
    mov.d $f12, $f0
    syscall

    la	$a0, is		    # display is message
    li	$v0, 4
    syscall

    jal exp				# if x != 999 then call exp

    li $v0, 3				# display result
    mov.d $f12, $f0
    syscall

    # print exp
    j expdriver

# Function to compute e ^ x = 1 + x / 1 + x ^ 2 / 2! + x ^ 3 / 3! + ...
exp:
	# f0 is result, $f12 is input
	mov.d $f10 ,$f12
	# x = abs(x)
	abs.d $f12, $f12
	# f0 is 1
	l.d $f0, one			# $f12 = 999
	# t0 is count
	li $t0, 1

	addi	$sp, $sp, -4	# adjust stack for 2 items
	sw	$ra, 0($sp)	# save the return address

	jal exploop

    lw	$ra, 0($sp)	# restore the return address
    addi	$sp, $sp, 4	# adjust stack pointer to pop 2 items

	l.d $f12, zero
    c.lt.d $f6, $f10		# is input < 0 ?
    bc1f expinverse				# then exit

	jr $ra

expinverse:
	l.d $f12, one
	div.d $f0, $f12, $f0
	jr $ra

exploop:
	# get next term
	li $t1, 0
	l.d $f2, one
	addi	$sp, $sp, -4	# adjust stack for 2 items
    sw	$ra, 0($sp)	# save the return address
	jal termloop
	lw	$ra, 0($sp)	# restore the return address
    addi	$sp, $sp, 4	# adjust stack pointer to pop 2 items
	# if next term / current sum < 1.0e-15 exit
	l.d $f4, term			# $f4 = 1.0e-15
	div.d $f6, $f2, $f0		# f6 = res / sum
	c.lt.d $f6, $f4		# is divisor < 1.0e-15 ?
    bc1t expr				# then exit
    nop
    # otherwise
    add.d $f0, $f0, $f2
    addi $t0, $t0, 1

    j exploop

termloop:
	beq $t0, $t1, termloopexit	# for t1 = 0 to t0
	mul.d $f2, $f12, $f2		# f2 = f2 * f12
	addi $t1, $t1, 1			# t1 += 1
	mtc1.d $t1, $f4
    cvt.d.w $f4, $f4
	div.d $f2, $f2, $f4		# f2 = f2 / f13
	j termloop

termloopexit:
	jr $ra

expr:
	jr $ra

exit:
	la	$a0, bye		    # display welcome message
    li	$v0, 4
    syscall

    li	$v0, 10				# exit
    syscall

	.data
zero: .double 0.0
one: .double 1.0
check: .double 999.0
term: .double 1.0e-15
welc: .asciiz "Let's test our exponential function"
menu: .asciiz "\nEnter a value for x (or 999 to exit): "
res: .asciiz "\nOur approximation for e^"
is: .asciiz " is "
bye: .asciiz "\nCome back soon"