addem:  add       $v0, $a0, $a1
        jr        $ra


main:
        li        $a0, 2
        li        $a1, 4

        jal       addem

        move      $s0, $v0
        li        $v0, 1
        syscall

        la        $a0, plus
        li        $v0, 4
        syscall

        move      $a0, $a1
        li        $v0, 1
        syscall

        la        $a0, equals
        li        $v0, 4
        syscall

        move      $a0, $s0
        li        $v0, 1
        syscall

        la        $a0, cr
        li        $v0, 4
        syscall

        li        $v0, 10
        syscall

        .data
plus:   .asciiz        " + "
equals: .asciiz        " = "
cr:     .asciiz        "\n"