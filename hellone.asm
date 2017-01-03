.text
.globl main

main:
    la $a0, word
    lw $s1, 0($a0)
    li $v0, 10
    syscall

.data
word: .asciiz "hellone"
