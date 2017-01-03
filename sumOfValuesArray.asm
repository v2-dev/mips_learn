#sum of values in an array

.text
.globl main

main:

    li $s0, 10 #load immediate (pseudoinstruction)
    la $s1, array #load address (pseudoinstruction)
    add $s2, $zero, $zero #cycle counter
    add $t2, $zero, $zero #sum

loop:
    lw $t1, 0($s1) #access to array
    add $t2, $t1, $t2 # sum += array[i]
    addi $s1, $s1, 4  # next element of array
    addi $s2, $s2, 1  # i++
    bne $s2, $s0, loop # if(i < 10) goto loop; else exit
    jr $ra

.data
array:  .word 1,2,3,4,5,6,7,8,9,10
