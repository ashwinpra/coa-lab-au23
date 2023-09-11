.data 

num_prompt:
    .asciiz "Enter a number: "
output_prompt:
    .asciiz "\nThe number is now: "
end_prompt:
    .asciiz "\n\nThe number has reached 1. "

.text
.globl main

collatz_it:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp) # n

    li $s2, 2 
    li $s3, 3

    move $t0, $a0

    loop:
        beq $t0, 1, end_it

        rem $t1, $t0, 2
        beq $t1, 0, even_it

        mul $t0, $t0, $s3
        addi $t0, $t0, 1
        
        li $v0, 4
        la $a0, output_prompt
        syscall

        li $v0, 1
        move $a0, $t0
        syscall

        j loop

    even_it:
        div $t0, $s2
        mflo $t0

        li $v0, 4
        la $a0, output_prompt
        syscall

        li $v0, 1
        move $a0, $t0
        syscall

        j loop

    end_it:
        li $v0, 4
        la $a0, end_prompt
        syscall

        lw $ra, 0($sp)
        lw $a0, 4($sp)
        addi $sp, $sp, 8

        jr $ra

collatz_rec:
    # base case: n = 1 => return
    # recursive case: n is even => collatz_rec(n/2)
    # recursive case: n is odd => collatz_rec(3n+1)

    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $a0, 4($sp) # n

    li $v0, 4
    la $a0, output_prompt
    syscall

    li $v0, 1
    move $a0, $t0
    syscall

    li $s2, 2
    li $s3, 3

    move $t0, $a0

    # base case
    beq $t0, 1, end_rec

    # recursive case: n is even
    rem $t1, $t0, 2
    beq $t1, 0, even_rec

    # recursive case: n is odd
    mul $t0, $t0, $s3
    addi $t0, $t0, 1
    move $a0, $t0
    jal collatz_rec

    j end_rec

    even_rec:
        div $t0, $s2
        mflo $t0
        move $a0, $t0
        jal collatz_rec

    end_rec:
        lw $ra, 0($sp)
        lw $a0, 4($sp)
        addi $sp, $sp, 8

        jr $ra

main:
    li $v0, 4
    la $a0, num_prompt
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    move $a0, $t0
    # jal collatz_it

    jal collatz_rec

    li $v0, 10
    syscall
