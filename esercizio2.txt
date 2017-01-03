.globl main

main:
      addi $s0, $zero, 1
      addi $s1, $zero, 2
      addi $a0, $zero, 5
      addi $a1, $zero, 6
      addi $a2, $zero, 4
      addi $a3, $zero, 3
      jal leaf_example
      li  $v0, 10 # load code for program end
      syscall	# exit

        leaf_example:
              addi $sp, $sp, -4
              # decrementa lo stack di 4 per salvare $s0
              sw $s0, 0($sp)# push di $s0 nello stack
              add $t0, $a0, $a1
              add $t1, $a2, $a3
              sub $s0, $t0, $t1
              # $t0 = g + h
              # $t1 = i + j
              # f = $t0 - $t1
              add $v0, $s0, $zero # restituisci f come risultato
              lw $s0, 0($sp) # pop di $s0 dallo stack
              addi $sp, $sp, 4# incrementa lo stack
              jr $ra
              # ritorna alla procedura chiamante
