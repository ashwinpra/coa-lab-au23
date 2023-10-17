# Assignment 4, Question 1
# Autumn Semester 2023-24 (Semester 5)
# Group No. 24 
# Gorantla Thoyajakshi - 21CS10026
# Ashwin Prasanth - 21CS30009

.data
    input_prompt:
        .asciiz "Enter value for n: "
    output_prompt:
        .asciiz "The sum of the series is: "
    invalid_prompt:
        .asciiz "Invalid input. Exiting program.\n"

.text
.globl main

# function to calculate n^n
# input is taken in $a1
# output is stored in $v1
cal_npown:
    addi $sp, $sp, -8 # allocate space for $ra and $t1
    sw $ra, 0($sp) # store $ra in stack
    sw $t1, 4($sp) # store $t1 in stack

    move $t1, $a1 # store the value of n in $t1

    li $v1, 1 # initialize result to 1 

    li $t3, 1 # counter 

    calc_loop:
        bgt $t3, $t1, exit_calc # if counter == n, exit loop

        mul $v1, $v1, $t1 # multiply result with n

        addi $t3, $t3, 1 # increment counter

        j calc_loop # repeat loop
    
    exit_calc:
        lw $ra, 0($sp) # restore $ra
        lw $t1, 4($sp) # restore $t1
        addi $sp, $sp, 8 # deallocate stack

        jr $ra # return to caller

# function to calculate sum of series recursively
# input is taken in $a0
# output is stored in $v0
sum_series:
    addi $sp, $sp, -8 # allocate space for $ra and $t0
    sw $ra, 0($sp) # store $ra in stack
    sw $t0, 4($sp) # store $t0 in stack

    move $t0, $a0 # store the value of n in $t0 (for calculating n^n) 

    # if n == 1, return 1, ie n
    move $v0, $a0
    beq $a0, 1, exit_rec 

    # else, calculate n^n and add it to the sum of the series for n-1
    addi $a0, $a0, -1 # get n-1 to run sum_series(n-1)
    jal sum_series # recursive call to sum_series(n-1)

    # calculate the value n^n
    move $a1, $t0 # move n to $a1 as parameter for cal_npown
    jal cal_npown
    # result is stored in $v1

    add $v0, $v0, $v1 # add the result to the sum of the series for n-1


    exit_rec:
        lw $ra, 0($sp) # restore $ra
        lw $t0, 4($sp) # restore $t0
        addi $sp, $sp, 8 # pop stack

        jr $ra # return to caller

main:
    li $v0, 4
    la $a0, input_prompt
    syscall # printing input prompt for  n

    li $v0, 5
    syscall
    move $t0, $v0 # reading n
    
    ble $t0, 0, invalid_input # if n <= 0, exit

    # calculate the sum using recursive formula: sum_series(n) = sum_series(n-1) + n^n
    move $a0, $t0 # move n to $a0 as parameter for sum_series
    jal sum_series # call sum_series(n)

    # move result so that it is not overwritten 
    move $t1, $v0

    li $v0, 4
    la $a0, output_prompt
    syscall # printing output prompt for sum of series

    # print the result
    move $a0, $t1
    li $v0, 1
    syscall

    j exit # jump to exit

    invalid_input:
        li $v0, 4
        la $a0, invalid_prompt
        syscall # printing invalid input prompt

    exit: 
        li $v0, 10
        syscall # exit

