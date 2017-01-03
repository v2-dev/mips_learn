.text
.globl main

main:
    la $a0, address
    lw $s1, 0($a0)  #Little endian or big endian?
    li  $v0, 10 # load code for program end
    syscall	# exit

.data
    address: .half 367788998 #Store the 16-bit quantities in successive memory halfwords.
