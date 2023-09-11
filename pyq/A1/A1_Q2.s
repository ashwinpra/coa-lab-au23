# Read two _positive_ integers and calculate their GCD by repeated subtraction

.data 
    prompt1:
        .asciiz "Enter first number: "
    prompt2:
        .asciiz "Enter second number: "
    output:
        .asciiz "GCD is: "
    newline:
        .asciiz "\n"

.text
.globl main

main:
    # Print prompt1
    li $v0, 4
    la $a0, prompt1
    syscall

    # Read first number
    li $v0, 5
    syscall
    move $t0, $v0

    # Print prompt2
    li $v0, 4
    la $a0, prompt2
    syscall

    # Read second number
    li $v0, 5
    syscall
    move $t1, $v0

    # Calculate GCD
    move $t2, $t0
    move $t3, $t1
    loop:
        bne $t2, $t3, not_equal
        move $t4, $t2
    not_equal:
        bgt $t2, $t3, greater
        sub $t3, $t3, $t2
        j loop
    greater:
        sub $t2, $t2, $t3
        j loop

    # Print output
    li $v0, 4
    la $a0, output
    syscall

    # Print GCD
    li $v0, 1
    move $a0, $t4
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Exit
    li $v0, 10
    syscall