# Assignment 3, Question 1
# Autumn Semester 2023-24 (Semester 5)
# Group No. 24 
# Gorantla Thoyajakshi - 21CS10026
# Ashwin Prasanth - 21CS30009

.data
    size_prompt: 
        .asciiz "Enter the size of the array: "
    array_prompt:
        .asciiz "Enter the elements of the array: \n"
    element_prompt:
        .asciiz "Enter element: "
    out_prompt:
        .asciiz "Max Circular Sum: "

.text 
.globl main

# utility functions that will be used to find max and min (explained in document)
find_mh:
    bgt $t8, $t9, set_mh
    move $t4, $t9
    jr $ra

set_mh:
    move $t4, $t8
    jr $ra

find_msf:
    bgt $t4, $t3, set_msf
    jr $ra

set_msf:
    move $t3, $t4
    jr $ra

find_mih:
    blt $t8, $t9, set_mih
    move $t6, $t9  
    jr $ra

set_mih:
    move $t6, $t8
    jr $ra

find_misf:
    blt $t6, $t5, set_misf
    jr $ra

set_misf:
    move $t5, $t6 
    jr $ra

# $s0 -> array size 
# $t1 -> start address of array (keeps incrementing)
# $t2 -> end address of array
# $t7 -> array total sum

main:
    la $a0, size_prompt  
    li $v0, 4
    syscall # prompt user for array size

    li $v0, 5 
    syscall
    move $s0, $v0 # get array size from user

    sll $t2, $s0, 2   # multiplied by 4 to get offset
    add $t2, $t2, $sp  
    add $t1, $zero, $sp 

    la $a0, array_prompt
    li $v0, 4
    syscall # ask user for elements

    li $t7, 0
    li $t4, 0  # t4 works as i for traversal

read_array:
    la $a0, element_prompt 
    li $v0, 4
    syscall # asking user for arr[i]

    li $v0, 5     
    syscall
    move $t3, $v0 # reading arr[i] temporarily in t3

    add $t7, $t7, $t3 # adding t3(arr[i]) to sum
    sw $t3, ($t1) # storing t3 at arr[i]

    addi $t1, $t1, 4 # incrementing array pointer
    addi $t4, $t4, 1 # incrementing i 

    bge $t1, $t2, max_sum # jump to max_sum once over
    j read_array # else, continue

max_sum:
    add $t1, $zero, $sp # initialise t1 to starting address again
    # load the value at t1 into each (arr[0])
    lw $t3, 0($t1)   # t3 = max here (mh)
    lw $t4, 0($t1)   # t4 = max so far (both initialised to small values) (msf)
    lw $t5, 0($t1)    # t5 = min here (mih)
    lw $t6, 0($t1)    # t6 = min so far (both initialised to large values) (misf)

    # incrementing array pointer 
    addi $t1, $t1, 4

    j find_sums_loop # loop to update each of the above 4

# here, each of the above 4 are updated based on the 
find_sums_loop:

    lw $t8, ($t1) # loading arr[i]

    add $t9, $t8, $t4  # loading msf + arr[i]

    # functions to check max here and max so far
    jal find_mh 
    jal find_msf

    add $t9, $t8, $t6 # loading misf + arr[i]

    # functions to check min here and min so far
    jal find_mih
    jal find_misf

    # incrementing array pointer to next element
    add $t1, $t1, 4

    bge $t1, $t2, find_max_circ_sum # jump to find_max_circ_sum once over
    j find_sums_loop    #else, continue


find_max_circ_sum:
    sub $t1, $t7, $t5     # t1 = total sum - misf
    bgt $t1, $t3, show_ans  # if t1 > msf, then that is the answer 
    move $t1, $t3         # else, the answer is msf (moved to t1)

show_ans:
    la $a0, out_prompt 
    li $v0, 4
    syscall # output final answer

    move $a0, $t1   
    li $v0, 1
    syscall # output the number

li $v0, 10   
syscall