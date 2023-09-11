# Check if it is a perfect number 

.data
    prompt: 
        .asciiz "Enter a number: "
    perfect_out: 
        .asciiz "The number is perfect"
    not_perfect_out: 
        .asciiz "The number is not perfect"

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

    # Check if number is perfect
    li $t1, 1
    li $t2, 2
    li $t3, 0
    li $t4, 0

    loop:
        # Check if t2 is greater than t0
        bgt $t2, $t0, end_loop

        # Check if t0 is divisible by t2
        div $t0, $t2
        mfhi $t3
        beq $t3, $t4, add_to_sum

        # Increment t2
        addi $t2, $t2, 1
        b loop

    add_to_sum:
        # Add t2 to t1
        add $t1, $t1, $t2

        # Increment t2
        addi $t2, $t2, 1
        b loop

    end_loop:
        # Check if t1 is equal to t0
        beq $t1, $t0, perfect

        # Print not perfect
        li $v0, 4
        la $a0, not_perfect_out
        syscall
        b exit

    perfect:
        # Print perfect
        li $v0, 4
        la $a0, perfect_out
        syscall

    exit:
        # Exit program
        li $v0, 10
        syscall
