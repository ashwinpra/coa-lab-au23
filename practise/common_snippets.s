###? ------ Printing a string ------
li $v0, 4
la $a0, string
syscall

###? ----- Taking input from user ------
li $v0, 5
syscall
move $t0, $v0 # $t0 -> user input

###? ----- Printing an integer ------
li $v0, 1
move $a0, $t0
syscall


###? ------- taking array input - dynamically allocated ------- 
main:
    la $a0, size_prompt  
    li $v0, 4
    syscall # prompt user for array size

    li $v0, 5 
    syscall
    move $s0, $v0 # get array size from user

    sll $t2, $s0, 2
    add $t2, $t2, $sp  # end of array
    add $t1, $zero, $sp  # start of array

    la $a0, array_prompt
    li $v0, 4
    syscall # ask user for elements

    li $t4, 0  # t4 -> i 

    read_array:
        la $a0, element_prompt 
        li $v0, 4
        syscall # asking user for arr[i]

        li $v0, 5     
        syscall
        move $t3, $v0 # reading arr[i] temporarily in t3

        sw $t3, ($t1) # storing t3 at arr[i]

        addi $t1, $t1, 4 # incrementing array pointer
        addi $t4, $t4, 1 # incrementing i 

        bge $t1, $t2, next_step # add next step here

        j read_array # else, continue

###? ------- taking array input - fixed size ---------

.align 4
arr: 
    .space 400 # arbitrary size

main:
    la $a0, size_prompt  
    li $v0, 4
    syscall # prompt user for array size

    li $v0, 5 
    syscall
    move $s0, $v0 # get array size from user

    
    la $a0, array_prompt
    li $v0, 4
    syscall # ask user for elements

    li $t1, 0  # t1 -> i
    la $t2, arr

    read_array:
        sll $t4, $t1, 2
        add $t4, $t4, $t2 # t4 -> &arr[i]

        la $a0, element_prompt
        li $v0, 4
        syscall # asking user for arr[i]

        li $v0, 5
        syscall

        sw $v0, ($t4) # storing arr[i] in arr

        addi $t1, $t1, 1 # incrementing i

        bge $t1, $s0, next_step # add next step here

        j read_array # else, continue

###? --------- Printing array - dynamic -------

print_array:
        la $a0, print_prompt
        li $v0, 4
        syscall # print "The array is: "

        li $t1, 0 # t1 -> i
        
        add $t1, $zero, $sp # t1 -> &arr[0]

        print_loop:
            lw $a0, 0($t1) # a0 -> arr[i]
            li $v0, 1
            syscall # print arr[i]

            li $a0, 32
            li $v0, 11
            syscall # print space

            addi $t1, $t1, 4 # increment i

            bge $t1, $t2, exit # add next step here

            j print_loop # else, continue

    exit:
        li $v0, 10
        syscall # exit


###? --------- Printing array - fixed size ----------

print_array:
        li $s0, 5   
        
        la $a0, print_prompt
        li $v0, 4
        syscall # print "The array is: "

        li $t1, 0 # t1 -> i
        la $t2, arr

        print_loop:
            sll $t4, $t1, 2
            add $t4, $t4, $t2 # t4 -> &arr[i]

            lw $a0, ($t4) # a0 -> arr[i]
            li $v0, 1
            syscall # print arr[i]

            li $a0, 32
            li $v0, 11
            syscall # print space

            addi $t1, $t1, 1 # increment i

            bge $t1, $s0, exit # add next step here

            j print_loop # else, continue


###? ------- Nested procedure calls -------
"""
example: 
    int non_leaf() {
        func1();
        return 42
    }
"""

non_leaf:
    addi $sp, $sp, -4 # space to save 1 register, $ra -> prologue
    sw $ra, 0($sp)

    jal func1

    li $v0, 42 # return 42

    lw $ra, 0($sp) # restore original $ra
    addi $sp, $sp, 4 # pop the stack -> epilogue

    jr $ra

###? ------- saving values across a function call -------

"""
example:
    void print_letters(char letter, int count) 
    {
        for (int i=0; i<count; i++){
            putchar(letter);
        }
        putchar('\n');
    }

    int save_vals(){
        for(int i=0;i<10;i++) {
            print_letters('A'+i, i+1); 
        }
        return 8;
    }
"""

print_letters:
    ble $a1, 0, exit_pl # if count <= 0, exit (sanity check)
    li $v0, 11 # print character

    pl_loop:
        syscall 
        addi $a1, $a1, -1 # decrement count
        bgt $a1, $zero, pl_loop # if count > 0, continue

        li $a0, 10 # print newline
        syscall
    
    exit_pl:
        jr $ra

save_vals:
    addi $sp, $sp, -12 # space to save 3 registers, $ra, $s0, $s1 -> prologue

    sw $ra, 0($sp) # save $ra
    sw $s0, 4($sp) # save $s0
    sw $s1, 8($sp) # save $s1

    li $s0, 0 # i = 0 
    li $s1, 10 # upper limit => 10

    sv_loop:
        addi $a0, $s0, 65
        addi $a1, $s0, 1

        jal print_letters

        addi $s0, $s0, 1 # increment i
        bgt $s0, $s1, exit_sv # if i > 10, exit

        j sv_loop # else, continue

        exit_sv:
            lw $ra, 0($sp) # restore original $ra
            lw $s0, 4($sp) # restore original $s0
            lw $s1, 8($sp) # restore original $s1

            addi $sp, $sp, 12 # pop the stack -> epilogue

            jr $ra


###? ------- Recursive procedure calls -------
""" 
example:
    int fib(int n) {
        if (n <= 1) {
            return n;
        }
        return fib(n-1) + fib(n-2);
    }
"""

fib:
    addi $sp, $sp, -8 # space to save 2 registers, $ra, $s0 -> prologue
    sw $ra, 0($sp) # save $ra
    sw $s0, 4($sp) # save $s0

    move $v0, $a0 # preparing to return n
    li $t0, 1 
    ble $a0, $t0, exit_fib # if n <= 1, exit

    move $s0, $a0 # s0 -> n

    addi $a0, $s0, -1 # fib(n-1)
    jal fib

    addi $a0, $s0, -2 # fib(n-2)
    move $s0, $v0 # s0 -> fib(n-1)
    jal fib

    add $v0, $s0, $v0 # return fib(n-1) + fib(n-2)

    exit_fib:
        lw $ra, 0($sp) # restore original $ra
        lw $s0, 4($sp) # restore original $s0

        addi $sp, $sp, 8 # pop the stack -> epilogue

        jr $ra


###? -------- switch cases --------
"""
example:
    printf("Enter your grade (capital): ");
    int grade = getchar();
    switch (grade) {
        case 'A':
            printf("Excellent!\n");
            break;
        case 'B':
            printf("Good!\n");
            break;
        case 'C':
            printf("At least you passed?\n");
            break;
        case 'D':
            printf("Probably should have dropped it...\n");
            break;
        case 'F':
            printf("Makhaya\n");
            break;
        default:
            printf("Invalid grade!\n");
    }
"""

.data

a_str: .asciiz "Excellent!\n"
b_str: .asciiz "Good!\n"
c_str: .asciiz "At least you passed?\n"
d_str: .asciiz "Probably should have dropped it...\n"
f_str: .asciiz "Makhaya\n"
invalid_str: .asciiz "Invalid grade!\n"
grade_prompt: .asciiz "Enter your grade (capital): "

switch_labels: .word a_label, b_label, c_label, d_label, f_label, invalid_label

.text 
.globl main 

main:
    li $v0, 4
    la $a0, enter_grade
    syscall

    li $v0, 12 
    syscall 

    li $t2, 5 # index 5 => f 

    la $t0, switch_labels

    addi $t1, $v0, -65 # t1 -> grade - 'A'

    blt $t1, $0, invalid_label # if grade < 'A', invalid
    bgt $t1, $t2, invalid_label # if grade > 'F', invalid

    sll $t1, $t1, 2 # multiply by 4
    add $t0, $t0, $t1 # t0 -> address of label

    lw $t0, 0($t0) # load label address

    jr $t0

a_label:
    la $a0, a_str
    j exit

b_label:
    la $a0, b_str
    j exit

c_label:
    la $a0, c_str
    j exit

d_label:
    la $a0, d_str
    j exit

f_label:
    la $a0, f_str
    j exit

invalid_label:
    la $a0, invalid_str

exit: 
    li $v0, 4
    syscall

    li $v0, 10
    syscall

