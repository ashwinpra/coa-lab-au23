.data
    number_prompt:
        .asciiz "Please enter a number (<11 digits): "
    out_msg:
        .asciiz "\n The sum of individual digits is: "
    newline:
        .asciiz "\n"
    number:
        .space 11

.text

# t0 -> number 
# t1 -> digit
# t2 -> sum

.globl main
    main:
        la $a0,number_prompt
        li $v0,4
        syscall

        la $a0,number
        li $a1,11
        li $v0,8
        syscall

        la $a0,out_msg
        li $v0,4
        syscall

        la $t0, number #pointer to number
        li $t2,0 #initialize sum=0

        loop:
            lb $t1,($t0) # load a byte from the memory address pointer by $t0
            beq $t1,0xA,exit_loop # Check if it is linefeed
            beqz $t1,exit_loop # Check if it is a null character
            and $t1,$t1,0x0F # Mask the upper four bits, to obtain the decimal value
            addu $t2,$t2,$t1 # add and accumulate
            addu $t0,$t0,1 # Move the pointer by one byte
            b loop

        exit_loop:
            move $a0,$t2 #output sum
            li $v0,1
            syscall

            la $a0,newline #output newline
            li $v0,4
            syscall

        exit:
            li $v0,10
            syscall



