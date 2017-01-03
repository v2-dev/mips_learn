.text

.globl main


main:	addi $sp,$sp,-4
	sw   $ra,0($sp)

	la   $a0,A
	la   $a1,B
	la   $a2,C
	addi $a3,$0,8	# lunghezza array

	jal  addizionatore

	lw   $ra,0($sp)
	addi $sp,$sp,4
	jr   $ra


addizionatore:
	addi	$sp, $sp, -20
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)

	add	$s0, $a0, $0	# $s0=A
	add	$s1, $a1, $0	# $s1=B
	add	$s2, $a2, $0	# $s2=C
	add	$s3, $a3, $0	# $s3=n

	sll	$t0, $s3, 2	# $t0=n*4
	add	$s4, $s0, $t0	# $s4=&A[n]
	add	$s1, $s1, $t0	# $s1=&B[n]
	add	$s2, $s2, $t0	# $s2=&C[n]

	add	$a2, $0,  $0	# $a2=c_in=0

Loop:	addi 	$s4, $s4, -4	# punta al precedente in A
	addi 	$s1, $s1, -4	# punta al precedente in B
	addi 	$s2, $s2, -4	# punta al precedente in C

	lw	$a0, 0($s4)	# $a0=elemento corrente di A
	lw 	$a1, 0($s1)	# $a1=elemento corrente di B
	jal 	add_bit

	sw	$v0, 0($s2)	# scrivi sum nell'elemento corrente di C
	add	$a2, $0, $v1	# $a2=c_in=c_out

	beq	$s4, $s0, Exit_addizionatore	# if ($s4==A) esci
	j	Loop


	lw	$t0, 0($s4)	# $a0=segno di A
	lw 	$t1, 0($s1)	# $a1=segno di B
	add	$v1, $0, $0	# $v1=c_out=0
	bne	$t0, $t1, Exit_addizionatore	# Se il segno operandi � diverso
	beq	$t0, $v0, Exit_addizionatore	# o se il segno del risultato � uguale a
						# quello degli operandi
	add	$v1, $0, 1	# altrimenti overflow --> $v1=1

Exit_addizionatore:
	lw	$s3, 16($sp)
	lw	$s2, 12($sp)
	lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addi 	$sp, $sp, 20
	jr	$ra



add_bit:addi	$sp, $sp, -20
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	sw	$s3, 16($sp)

	add	$s0, $a0, $0	# $s0=a
	add	$s1, $a1, $0	# $s1=b
	add	$s2, $a2, $0	# $s2=c_in
	jal	bit_xor

	add	$s3, $0,  $v0	# $s3= a xor b (we need it later)
	add	$a0, $0,  $v0	# $a0= a xor b
	add	$a1, $s2, $0	# $a1= c_in
	jal 	bit_xor		# $v0= Sum = c xor (a xor b)

	and	$t1, $s0, $s1	# $t1= a AND b
	and 	$t2, $s2, $s3	# $t2= c_in AND (a xor b)
	or	$v1, $t1, $t2	# $v1= c_out=$t1 OR $t2

	lw	$s3, 16($sp)
	lw	$s2, 12($sp)
	lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	addi 	$sp, $sp, 20
	jr	$ra


bit_xor:add	$v0, $0,  $0	# $v0=0
	beq	$a0, $a1, Exit_xor # if $a0=$a1 return 0
	addi	$v0, $0,  1	# else return 1
Exit_xor:jr	$ra


.data

A: 	.word 1,0,1,1,0,1,0,0
B:	.word 0,1,0,0,1,0,0,0
C:	.space 8
