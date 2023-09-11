.data

size_prompt:
    .asciiz "Enter size of the array: "
    
array_prompt:
    .asciiz "Enter the elements of the array: "

min_prompt:
    .asciiz "Index of the minimum element is: "

max_prompt:
    .asciiz "Index of the maximum element is: "

.text
.globl main

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
        li $v0, 5     
        syscall
        move $t3, $v0 # reading arr[i] temporarily in t3

        sw $t3, ($t1) # storing t3 at arr[i]

        addi $t1, $t1, 4 # incrementing array pointer
        addi $t4, $t4, 1 # incrementing i 

        bge $t1, $t2, get_minmax # add next step here

        j read_array # else, continue

    get_minmax:
        # $t5 -> min index 
        # $t6 -> max index

        add $t1, $zero, $sp # reset array pointer

        li $t5, 0 # min = arr[0]
        li $t6, 0 # max = arr[0]

        addi $t1, $t1, 4 # increment array pointer

        li $t4, 1 # i = 1

        loop:
            lw $t3, 0($t1) # t3 = arr[i]

            blt $t3, $t5, update_min # if t3 < min, update min
            bgt $t3, $t6, update_max # if t3 > max, update max

            post_update:
                addi $t1, $t1, 4 # increment array pointer
                addi $t4, $t4, 1 # increment i

                bge $t4, $s0, print_minmax # if i >= n, print min and max

                j loop # else, continue

        update_min:
            add $t5, $zero, $t4 # min = i
            j post_update

        update_max:
            add $t6, $zero, $t4 # max = i
            j post_update

    print_minmax:
        la $a0, min_prompt
        li $v0, 4
        syscall # print min prompt

        move $a0, $t5
        li $v0, 1
        syscall # print min

        li $a0, 10
        li $v0, 11
        syscall # print newline

        la $a0, max_prompt
        li $v0, 4
        syscall # print max prompt

        move $a0, $t6
        li $v0, 1
        syscall # print max

        j exit


    exit:
        li $v0, 10
        syscall # exit