# Multiply two 16 bit numbers (in 2's complement form) using Booth's Multiplication Algorithm

.data
    n1_prompt: 
        .asciiz "Enter the first number: "
    n2_prompt:
        .asciiz "Enter the second number: "
    result:
        .asciiz "Product of the two numbers are: "

.text 
.globl main 

main:
    # Get first number 
    li $v0, 4
    la $a0, n1_prompt
    syscall

    # Read first number
    li $v0, 5
    syscall
    move $s0, $v0

    # Get second number
    li $v0, 4
    la $a0, n2_prompt
    syscall

    # Read second number
    li $v0, 5
    syscall
    move $s1, $v0

    # Make procedure "multiply_booth", with arguments $s0 and $s1, sent through $a0 and $a1
    move $a0, $s0
    move $a1, $s1
    jal multiply_booth

    # Print result
    li $v0, 4
    la $a0, result
    syscall

    # Print result
    li $v0, 1
    move $a0, $s2
    syscall

    # Exit
    li $v0, 10
    syscall

# multiply_booth has 2 arguments stored in $a0 and $a1
multiply_booth:
    # Save $ra
    addi $sp, $sp, -4
    sw $ra, 0($sp)  

    # Save $a0 and $a1
    addi $sp, $sp, -8
    sw $a0, 0($sp)
    sw $a1, 4($sp)

    

