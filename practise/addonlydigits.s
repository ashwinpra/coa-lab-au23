.data
    number_prompt:
        .asciiz "Please enter a string (<11 chars): "
    out_msg:
        .asciiz "\n The sum of digits is: "
    newline:
        .asciiz "\n"
    string:
        .space 11

.text

.globl main
    main:
        la $a0,number_prompt
        li $v0,4
        syscall

        la $a0,string
        li $a1,11
        li $v0,8
        syscall

        la $a0,out_msg
        li $v0,4
        syscall

        la $t0, string #pointer to number
        li $t2,0 #initialize sum=0

        loop:
            lb $t1,($t0) # load a byte from the memory address pointer by $t0
            beq $t1,0xA,exit_loop # Check if it is linefeed
            beqz $t1,exit_loop # Check if it is a null character

            # CHECK IF $t1 is a digit
            li $t3,0x30 # 0x30 is the ASCII code for '0'
            li $t4,0x39 # 0x39 is the ASCII code for '9'

            slt $t5,$t3,$t1 # Check if $t1 is greater than '0'
            slt $t6,$t1,$t4 # Check if $t1 is less than '9'

            # If both are true, then $t1 is a digit
            and $t7,$t5,$t6 # $t7 = $t5 & $t6

            beqz $t7,no_add # If $t7 is zero, then $t1 is not a digit
            
            and $t1,$t1,0xF # Convert ASCII code to digit
            addu $t2,$t2,$t1 # Add digit to sum



            addu $t0,$t0,1 # Increment the pointer

            b loop

        no_add:
            addu $t0,$t0,1 # Increment the pointer
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



