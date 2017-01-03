.text
#sum x, y variables
.globl main

main:
    lw $t1, x
    lw $t2, y
    add $t0, $t1, $t2
    sw $t0, z
    add $a0, $zero, $t0
    li $v0, 1
    syscall
    jr $ra

.data
    x:  .word 5
    y:  .word 7
    z:  .word 0
