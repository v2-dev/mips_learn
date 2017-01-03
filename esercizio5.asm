.text
.globl main

main:

    la $a0, number
    lw $s1, 0($a0)
    li $v0, 10
    syscall

.data
number: .word 45
