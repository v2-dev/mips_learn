.text

.globl main

main:
       addi $s0, $zero, 1
       addi $s1, $zero, 2
       addi $a0, $zero, 5
       addi $a1, $zero, 6
       addi $a2, $zero, 4
       addi $a3, $zero, 3
       jal example
       li  $v0, 10 # load code for program end
	     syscall	# exit


example:
      add $t0, $a0, $a1
      add $t1, $a2, $a3
      sub $s0, $t0, $t1
      # $t0 = g + h
      # $t1 = i + j
      # f = $t0 - $t1
      add $v0, $s0, $0
      jr $ra
      # restituisci f come risultato
      # ritorna alla procedura chiamante
