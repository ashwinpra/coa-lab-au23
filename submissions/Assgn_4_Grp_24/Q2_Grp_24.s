# Assignment 4, Question 2
# Autumn Semester 2023-24 (Semester 5)
# Group No. 24 
# Gorantla Thoyajakshi - 21CS10026
# Ashwin Prasanth - 21CS30009


.data 
input_prompt:
    .asciiz "Enter a number: "
output_prompt:
    .asciiz "Number of steps taken: "
invalid_prompt:
        .asciiz "Invalid input. Exiting program.\n"


.text
.globl main

# recursive function for collatz conjecture
# input: $a0 = n
# output: $s1 = number of steps taken
collatz:
    # base case: n = 1 => return
    # recursive case: n is even => collatz(n/2)
    # recursive case: n is odd => collatz(3n+1)

    addi $sp, $sp, -8 # allocate space for ra and t0
    sw $ra, 0($sp) # store $ra in stack
    sw $t0, 4($sp) # store $t0 in stack

    addi $s1, $s1, 1 # increment number of steps taken

    li $s2, 2 # storing constant 2 in $s2 for division
    li $s3, 3 # storing constant 3 in $s3 for multiplication

    move $t0, $a0 # storing n in $t0

    # base case
    beq $t0, 1, exit_rec # if n = 1, return

    
    rem $t1, $t0, 2 # check if n is even
    beq $t1, 0, even_rec # if n is even, go to even_rec 
    # else it goes below to odd_rec

    # recursive case 1: n is odd
    odd_rec:
        mul $t0, $t0, $s3 # 3n is being calculated
        addi $t0, $t0, 1 # adding 1 to 3n to get 3n+1
        
        move $a0, $t0 
        jal collatz # now collatz(3n+1) is called

        j exit_rec # jump to exit_rec

    # recursive case 2: n is even
    even_rec:
        div $t0, $s2 # n/2 is being calculated
        mflo $t0 # quotient is stored in $t0

        move $a0, $t0 
        jal collatz # now collatz(n/2) is called

    exit_rec:
        lw $ra, 0($sp) # restore $ra 
        lw $t0, 4($sp) # restore $t0
        addi $sp, $sp, 8 # pop stack

        jr $ra # return to caller

main:
    li $v0, 4
    la $a0, input_prompt
    syscall # printing input prompt for n

    li $v0, 5
    syscall
    move $t0, $v0 # reading n

    # sanity check to see if number is positive
    ble $t0, 0, invalid_input # if n <= 0, exit

    move $a0, $t0 # move n to $a0 as parameter for collatz
    li $s1, -1 # initialize number of steps taken to -1 (-1 because it counts the number itself as a step)
    jal collatz # calling collatz(n)

    li $v0, 4
    la $a0, output_prompt
    syscall # printing output prompt for number of steps taken

    move $a0, $s1
    li $v0, 1
    syscall # printing number of steps taken
    
    j exit # jump to exit

    invalid_input:
        li $v0, 4
        la $a0, invalid_prompt
        syscall # printing invalid input prompt

    exit:
        li $v0, 10
        syscall # exit
