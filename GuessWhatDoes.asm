.text
.globl main

main:
    la $a0, A
    la $a1, B
    la $a2, n
    addi $sp, $sp, -4
    sw $ra, 0($sp)

    jal Procedure

    lw $ra, 0($sp)
    addi $sp, $sp, 4
    jr $ra

Procedure:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)
    add $t0, $zero, $zero #k = 0
    add $t1, $zero, $zero #i = 0
    j loop

loop:

    slt $t2, $t1, $a2 #i < n
    beq $t2, $zero, exit_procedure #if (i < n) j exit; else continue;
    add $a3, $zero, $t1 #argument i for test
    addi $t1, $t1, 1 #i++
    jal Test
    #if(test(A, i)) continue; else exit_procedure
    beq $v1, $zero, loop
    sll $t3, $t0, 2 #k*4
    add $a1, $a1, $t3
    sll $t4, $t1, 2 #i = i*4
    add $t4, $a0, $t4 #&(A + i)
    sw $a1, 0($t4) #B[k] = A[i]
    addi $t0, $t0, 1 #k++
    j loop

exit_procedure:
    lw $a0, 0($sp)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    add $v1, $zero, $t0 #v0 = k
    addi $v0, $zero, 10
    syscall

Test:
    addi $sp, $sp, -4
    sw $ra, 0($sp)
    addi $t0, $zero, 1 #condition = 1
    addi $t1, $zero, -1 #j = 0
    j test_loop

test_loop:
    addi $t1, $t1, 1
    beq $t0, $zero, exit_loop #test condition == 1
    slt $t2, $t1, $a3 #if(j < n) continue; else exit;
    beq $t2, $zero, exit_loop
    sll $t3, $a3, 2
    add $t4, $t3, $a0
    sll $t5, $t1, 2
    add $t5, $t5, $a0
    sw $t6, 0($t4)
    sw $t7, 0($t5)
    slt $t4, $t6, $t7
    beq $t4, $zero, test_loop
    add $t0, $zero, $zero

exit_loop:
    add $v1, $zero, $t0
    lw $ra, 0($sp)
    jr $ra

.data
    A: .word 5,3,-1,0,8,4
    B: .word 0,0,0,0,0,0
    n: .word 1
