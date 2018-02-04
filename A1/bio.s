# Tyler O. Moses -- 01/14/2018
# bio.s -- Prints some information about me.
# Register uses:
#       $v0 syscall parameter and return value
#       $a0 syscall parameter

.text
        .globl  main
main:
        la $a0, msg     # address of bio message
        li $v0, 4       # this is the print_string option
        syscall         # perform the syscall

        li $v0, 10      # this is the exit option
        syscall

# Here is the data for the program
        .data
msg:    .asciiz         "My name is Tyler Moses\nI was born in Fort Myers, Florida\nI am a student at FSU and work at Anthem Inc as a Developer II\nI enjoy reading and writing"

# end bio.s

