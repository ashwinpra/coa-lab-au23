# Assignment 1, Question 1
# Autumn Semester 2023-24 (Semester 5)
# Group No. 24 
# Gorantla Thoyajakshi - 21CS10026
# Ashwin Prasanth - 21CS30009

.data 
    input_prompt: 
        .asciiz "Enter value of x for e^x: " 
    newline: 
        .asciiz "\n"
    output_prompt:
        .asciiz "e^x = " 
    term_output1:
        .asciiz "The loop terminated after: " 
    term_output2: 
        .asciiz " iterations"

.text 
    .globl main

    # $t0 = x
    # $t1 = sum (e^x)
    # $t2 = i
    # $t3 = x^i 
    # $t4 = i!
    # $t5 = current term to be added

    main: 
        li $v0, 4
        la $a0, input_prompt
        syscall #prompt user to input x

        li $v0, 5
        syscall
        move $t0, $v0 #getting input x from user

        li $v0, 4
        la $a0, newline
        syscall #newline

        li $v0, 4
        la $a0, output_prompt
        syscall #printing output statement

        li $t1, 1 #initialise sum to 1
        li $t2, 1 #initalise i to 1 
        li $t3, 1 #initalise x^i to 1
        li $t4, 1 #initalise i! to 1

        #in each iteration, $t3 is multiplied by x ($t0) to get x^i 
        #and $t4 is multiplied by i ($t2) to get i!
        #they are both divided to get x^i/i!, moved to $t5, which is then added to sum ($t1)

        #starting sum from x^1/1! (initialised it to 1 already)

        loop: 
            mul $t3, $t3, $t0 #updation of x^i by multiplying with x
            mul $t4, $t4, $t2 #updation of i! by multiplying with i

            div $t3, $t4 #dividing x^i with i! to get the current term

            mflo $t5 #getting the quotient from "lo" and moving it to $t5

            beqz $t5, exit_loop #exit loop if the current term is equal to zero i.e, sum doesnt change

            add $t1, $t1, $t5 # adding the current term to sum

            addi $t2, $t2, 1 #incrementing i

            b loop #continue loop
        
        exit_loop: 

            li $v0, 1
            move $a0, $t1 
            syscall # printing sum(e^x)

            li $v0, 4
            la $a0, newline
            syscall #newline

            li $v0, 4
            la $a0, term_output1
            syscall #printing output statement 

            # No. of iterations is calculated excluding the iteration in which sum didnt increase
            li $v0, 1
            move $a0, $t2 
            syscall #printing number of iterations

            li $v0, 4
            la $a0, term_output2
            syscall #printing output statement

            li $v0, 4
            la $a0, newline
            syscall #newline

            li $v0, 10
            syscall #termination of the program