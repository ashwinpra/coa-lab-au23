.data 

.input_prompt: 
    .asciiz "Enter four positive integers (n, a, r and m): "
.output_prompt:
    .asciiz "Final determinant of the matrix A is: "

.text
.globl main

main:
    # Print input prompt
    li $v0, 4
    la $a0, .input_prompt
    syscall

    # Read n, a, r and m
    li $v0, 5
    syscall
    move $s0, $v0

    li $v0, 5
    syscall
    move $s1, $v0

    li $v0, 5
    syscall
    move $s2, $v0

    li $v0, 5
    syscall
    move $s3, $v0

    