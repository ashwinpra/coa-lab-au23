# check if input is prime

.data
    prompt: 
        .asciiz "Enter a number: "
    composite_out: 
        .asciiz "Composite"
    prime_out: 
        .asciiz "Prime"

.text
.globl main 

main:
    # Prompt user to enter number
    li $v0, 4
    la $a0, prompt
    syscall

    # Read in number
    li $v0, 5
    syscall
    move $t0, $v0

    # compute n/2 -> upper limit of loop 
    srl $t1, $t0, 1

    # initialize counter 
    li $t2, 2

    loop:
        div		$t0, $t2			# $t0 / $t2
        mfhi	$t3					# $t3 = $t0 % $t2 
        beq		$t3, $zero, composite	# if $t3 == 0, then composite
        addi	$t2, $t2, 1			# increment counter
        bgt		$t2, $t1, prime		# if $t2 > $t1, then prime

        b loop

    composite:
        li $v0, 4
        la $a0, composite_out
        syscall
        b exit

    prime:
        li $v0, 4
        la $a0, prime_out
        syscall
        b exit

    exit:
        li $v0, 10
        syscall
        
        
