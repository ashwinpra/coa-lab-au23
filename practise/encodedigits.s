# input digit: 0 1 2 3 4 5 6 7 8 9 
# output digit: 4 6 9 5 0 3 1 8 7 2 

.data
    input_prompt: 
        .asciiz "Enter a string: "
    output: 
        .asciiz "The encoded string is: "
    continue_prompt:
        .asciiz "Do you want to continue? (y/Y/n/N) "
    newline: 
        .asciiz "\n"
    string:
        .space 21 # assuming maximum size of 20 

.text

    .globl main 

    main: 
        la $a0, input_prompt
        li $v0, 4
        syscall

        la $a0, string
        li $a1, 21
        li $v0, 8
        syscall

        la $a0, output
        li $v0, 4
        syscall

        # now we need to encode the string
        la $t0, string 

        loop:
            lb $t1, ($t0) # $t1 = current character
            beq $t1,0xA,exit_loop # Check if it is linefeed
            beqz $t1,exit_loop # Check if it is a null character

            # CHECK IF $t1 is a digit
            li $t3,0x30 # 0x30 is the ASCII code for '0'
            li $t4,0x39 # 0x39 is the ASCII code for '9'

            slt $t5,$t3,$t1 # Check if $t1 is greater than '0'
            slt $t6,$t1,$t4 # Check if $t1 is less than '9'

            # If both are true, then $t1 is a digit
            and $t7,$t5,$t6 # $t7 = $t5 & $t6

            beqz $t7,no_encode # If $t7 is zero, then $t1 is not a digit

            and $t1,$t1,0xF # Convert ASCII code to digit
            # depending on the digit, we need to encode it
            beq $t1,0,encode_0
            beq $t1,1,encode_1
            beq $t1,2,encode_2
            beq $t1,3,encode_3
            beq $t1,4,encode_4
            beq $t1,5,encode_5
            beq $t1,6,encode_6
            beq $t1,7,encode_7
            beq $t1,8,encode_8
            beq $t1,9,encode_9

            encode_0:
                li $t1,4
                b loop
            
            encode_1:
                li $t1,6
                b loop

            encode_2:
                li $t1,9
                b loop

            encode_3:
                li $t1,5
                b loop

            encode_4:
                li $t1,0
                b loop

            encode_5:
                li $t1,3
                b loop

            encode_6:
                li $t1,1
                b loop

            encode_7:   
                li $t1,8
                b loop

            encode_8:
                li $t1,7
                b loop

            encode_9:
                li $t1,2
                b loop

            no_encode:
                # do nothing
                b loop

            # print the encoded character
            sb $t1,($t0)

            addu $t0,$t0,1 # increment the pointer

            b loop

        exit_loop: 
            sb $zero,($t0) # add a null character to the end of the string

            la $a0, string
            li $v0, 4
            syscall

            la $a0, newline
            li $v0, 4
            syscall

            la $a0, continue_prompt
            li $v0, 4
            syscall

            li $v0, 12
            syscall

            beq $v0, 0x79, main # if $v0 == 'y', then continue
            beq $v0, 0x59, main # if $v0 == 'Y', then continue

            li $v0, 10
            syscall

