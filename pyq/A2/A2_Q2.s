.data

arr_prompt:
    .asciiz "Please enter 10 integers: "

.align 4
arr: 
    .space 40

k_prompt:
    .asciiz "Enter the value for k: "
output:
    .asciiz "The kth smallest element is: "


.text 
.globl main 

swap:
    addi $sp, $sp, -8
    sw $ra, 0($sp)
    sw $t2, 4($sp)

    move $t2, $a0 # j


    # temp = A[j]
    la $s1, arr
    sll $t2, $t2, 2
    add $s1, $s1, $t2

    lw $s2, 0($s1)
    lw $s3, 4($s1)

    sw $s3, 0($s1)
    sw $s2, 4($s1)

    addi $sp, $sp, 8
    lw $ra, 0($sp)
    lw $t2, 4($sp)

    jr $ra

main:
    li $v0, 4
    la $a0, arr_prompt
    syscall

    li $t2, 0

    li $s0, 10

    li $t1, 0  # t1 -> i
    la $t2, arr

    read_array:
        sll $t4, $t1, 2
        add $t4, $t4, $t2 # t4 -> &arr[i]

        li $v0, 5
        syscall

        sw $v0, ($t4) # storing arr[i] in arr

        addi $t1, $t1, 1 # incrementing i

        bge $t1, $s0, sort_array # add next step here

        j read_array # else, continue

    sort_array:
        li $t1, 0 # i = 0
        li $t2, 0 # j = 0

        la $t3, arr

        #    for i = 0 to n − 1 
        #        for j = 0 to n − i − 1
        #            if A[j] > A[j+1] then
        #            SWAP(A[j], A[j+1])

        fl_2:
            sll $t4, $t2, 2
            add $t4, $t4, $t3 # t4 -> &arr[j]

            sub $t7, $s0, $t1 # t5 -> n - i
            bge $t2, $t7, fl_1 

            # if A[j] > A[j+1] then swap
            lw $t5, ($t4)
            lw $t6, 4($t4)

            addi $t2, $t2, 1 # increment j

            ble $t5, $t6, fl_2 # if A[j] > A[j+1] then swap

            move $a0, $t2 # j
            jal swap 

            j fl_2 # else, continue

        fl_1:
            addi $t1, $t1, 1 # increment i

            bge $t1, $s0, exit # add next step here

            j fl_2 # else, continue

    exit:
        li $v0, 4
        la $a0, k_prompt
        syscall

        li $v0, 5
        syscall
        move $t3, $v0

        li $v0, 4
        la $a0, output
        syscall

        addi $t3, $t3, -1

        # get arr [k-1]
        sll $t4, $t3, 2

        la $t2, arr
        add $t4, $t4, $t2 # t4 -> &arr[k-1]

        lw $a0, ($t4)
        li $v0, 1
        syscall

        li $v0, 10
        syscall




