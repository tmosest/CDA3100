# Your Tyler O. Moses 02/19/2018
# Appropriate documentation
# insert your terms procedure and your Polish function here
# Driver program provided by Stephen P. Leach -- written 11/12/17
terms:
    # print ans intro
    move $t0, $a0
    la $a0, ans
    li $v0, 4
    syscall
    # print first given number
    move $a0, $t0
    li $v0, 1
    syscall
    # print space
    move $t0, $a0
    la $a0, space
    li $v0, 4
    syscall
    move $a0, $t0
    # loop to compute terms
    li $a1, 15
    li $a2, 0
    j loopTerms
loopTerms:
    beq $a1, $a2, loop       # if t1 == 16 we are done go back to main loop
    addi $a2, $a2, 1         # loop body
    # save a1, a2
    sub $sp, $sp, 8
    sw $a1, 4($sp)
    sw $a2, 0($sp)
    # call output term
    jal outputTerm
    # restore a1, and a2
    lw $a1, 4($sp)
    lw $a2, 0($sp)
    addi $sp, $sp, 8        # pop them off the stack
    j loopTerms
computeTerm:
    li $t1, 0
    li $t3, 10
    rem $t0, $a0, $t3         # Get the current digit
    mul $t0, $t0, $t0         # sqaure it
    add $a1, $a1, $t0         # add it to the result
    div $a0, $a0, 10          # n /= 10
    bne $t1, $a0, computeTerm
    jr $ra
outputTerm:
    li $a1, 0
    # save $ra
    sub $sp, $sp, 4
    sw $ra, 0($sp)
    # compute term
    jal computeTerm
    # print term
    move $a0, $a1
    move $t3, $a0
    li $v0, 1
    syscall
    # print space
    la $a0, space
    li $v0, 4
    syscall
    move $a0, $t3
    # load $ra
    lw $ra, 0($sp)
    addi $sp, $sp, 4
    # return to caller
    jr $ra
main:
    la $a0, intro       # print intro
    li $v0, 4
    syscall
loop:
    la $a0, req         # request value of n
    li $v0, 4
    syscall

    li $v0, 5           # read value of n
    syscall

    ble $v0, $0, out    # if n is not positive, exit

    move $a0, $v0       # set parameter for terms procedure

    jal terms           # call terms procedure

    j loop              # branch back for next value of n
out:
    la $a0, adios       # display closing
    li $v0, 4
    syscall

    li $v0, 10          # exit from the program
    syscall

    .data
intro: .asciiz  "Welcome to the Polish sequence tester!"
req: .asciiz  "\nEnter an integer (zero or negative to exit): "
ans: .asciiz "First 16 terms: "
space: .asciiz " "
adios: .asciiz "Come back soon!\n"