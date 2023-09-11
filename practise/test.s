.data

size_prompt: .asciiz "Enter the size of the array: "
array_prompt: .asciiz "Enter the elements of the array: "
element_prompt: .asciiz "Enter the element: "
print_prompt: .asciiz "The array is: "
newline: .asciiz "\n"

.align 4
arr: 
    .space 400 # arbitrary size



.text 
.globl main

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

        bge $t1, $s0, print_array # add next step here

        j read_array # else, continue

    print_array:
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

            la $a0, newline
            li $v0, 4
            syscall # print newline

            addi $t1, $t1, 1 # increment i

            bge $t1, $s0, exit # add next step here

            j print_loop # else, continue

    exit:
        li $v0, 10
        syscall # exit

