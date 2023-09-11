# Assignment 2, Question 1
# Autumn Semester 2023-24 (Semester 5)
# Group No. 24 
# Gorantla Thoyajakshi - 21CS10026
# Ashwin Prasanth - 21CS30009

.data 
    ip_prompt1: 
        .asciiz "Enter no. of cycles in permutation 1: "
    ip_prompt2: 
        .asciiz "Enter no. of cycles in permutation 2: "
    cycle_prompt1:
        .asciiz "Enter elements in cycle " 
    cycle_prompt2: 
        .asciiz "(Terminate cycle input by entering -1)"
    colon:
        .asciiz ": "  
    newline: 
        .asciiz "\n"
    op_prompt1:
        .asciiz "Product permutation cycle " 
    op_prompt2:
        .asciiz "is: "
    arr:
        .space 400 # max 10 elements * 10 max arrays = 400
    table:
        .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 # hash table to store elements

.text 
    .globl main

    # $s0 -> No. of cycles
    # $s1 -> i (to iterate over cycles)
    # $s2 -> incrementing variable for array storage
    # $s3 -> temporary variable for storing input

    main: 
        li $v0, 4
        la $a0, ip_prompt1
        syscall #prompt user to input no. of cycles in permutation 1

        li $v0, 5
        syscall 
        move $s0, $v0 #taking input of no. of cycles

        li $s1, 1 #initializing i = 1
        li $s2, 0 #array incrementing pointer 

        # loop for each cycle
        input_loop1:
            li $v0, 4
            la $a0, cycle_prompt1
            syscall #prompt user to input cycle

            li $v0, 1
            move $a0, $s1
            syscall #print cycle no.

            li $v0, 4
            la $a0, cycle_prompt2
            syscall #tell them to terminate cycle input by entering -1

            li $v0, 4
            la $a0, colon
            syscall #print ": "

            cycle_input_loop1:
                # declare an incrementing variable for array storage
                li $v0, 5
                syscall
                move $s3, $v0

                la $t0, arr # t0 -> temp variable for storing address of array
                add $t0, $t0, $s2
                move $t0, $s3 #taking input of element in cycle

                addi $s2, $s2, 4 #incrementing variable for array storage

                # check if input is -1
                beq $s3, -1, exit_cycle_input_loop1 #if yes, exit loop

                b cycle_input_loop1
            
            exit_cycle_input_loop1:
                mul $s2, $s1, 40 # set t4 to 40 * i to move to next array
                addi $s1, $s1, 1 # increment i
                ble $s1, $s0, input_loop1 #if i < no. of cycles, repeat loop


        # ----------------- end of taking permutation 1 input ------------------

        # here we will set t4 to 200 to store the second permutation
        li $s2, 200

        li $v0, 4
        la $a0, ip_prompt2
        syscall #prompt user to input no. of cycles in permutation 2

        li $v0, 5
        syscall 
        move $s0, $v0 #taking input of no. of cycles

        li $s1, 1 #initializing i = 1

        # loop for each cycle
        input_loop2:
            # # increment i
            # addi $s1, $s1, 1
            # bgt $s1, $s0, exit_loop # break if i > no. of cycles

            li $v0, 4
            la $a0, cycle_prompt1
            syscall #prompt user to input cycle

            li $v0, 1
            move $a0, $s1
            syscall #print cycle no.

            li $v0, 4
            la $a0, cycle_prompt2
            syscall #tell them to terminate cycle input by entering -1

            li $v0, 4
            la $a0, colon
            syscall #print ": "

            cycle_input_loop2:
                # declare an incrementing variable for array storage
                li $v0, 5
                syscall
                move $s3, $v0

                la $t0, arr
                add $t0, $t0, $s2
                move $t0, $s3 #taking input of element in cycle

                addi $s2, $s2, 4 #incrementing variable for array storage

                # check if input is -1
                beq $s3, -1, exit_cycle_input_loop2 #if yes, exit loop

                b cycle_input_loop2
            
            exit_cycle_input_loop2:
                li $s2, 40
                # add i 
                addi $s1, $s1, 1
                ble $s1, $s0, input_loop2 #if i < no. of cycles, repeat loop

        # ----------------- end of taking permutation 2 input ------------------

        # NOTE: Till here, our code is working, beyond this, we were not able to work on debugging the code

        # ---------------- start of algorithm ----------------------------------

        # iterate through each cycle in permutation 1

        # $s0 ->  To store initial value of s3 in the beginning of each cycle
        # $s1 -> i (to iterate over hash table entry) 
        # $s2 -> incrementing variable for hashtable storage
        # $s3 -> incrementing variable for array(arr) storage -> id
        # $s4 -> j, which will be used to increment $s3 by 40 * j to move to next cycle
        
        li $s1, 0 #initializing i = 0
        li $s2, 0 #array incrementing pointer

        # loop through elements of hash table - first run for permutation 1 
        hashtable_loop1: 
            # load table[i] into $t0
            la $t0, table
            add $t0, $t0, $s1
            lw $t0, 0($t0)

            # iterate through permutation 1

            li $s3, 0 #array incrementing pointer
            li $s4, 0 #initializing j = 1

            # loop through permutation
            perm_loop1:
                move $s0, $s3 # store initial value of s3
        
                # load arr[id] into $t1
                la $t1, arr
                add $t1, $t1, $s3
                lw $t1, 0($t1)

                # check if arr[id] == table[i]
                beq $t1, $t0, found1 #if yes, go to found

                addi $s3, $s3, 4 #incrementing variable for array storage

                # if arr[id] == -1, then move to next cycle by increasing pointer to 40 * j
                beq $t1, -1, next_cycle1 #if yes, go to next_cycle

                b perm_loop1
            
            found1:
                # update table[i] to arr[id+1] if arr[id+1] !=1, else arr[start_of_cycle]
                la $t1, arr
                add $t1, $t1, $s3
                lw $t1, 0($t1)

                addi $t1, $t1, 1 # increment arr[id+1]

                # check if arr[id+1] == -1
                beq $t1, -1, reset1 #if yes, reset to 0

                # else update table[i] to arr[id+1]
                la $t2, table
                add $t2, $t2, $s1
                sw $t1, 0($t2)
                
                reset1: 
                    la $t1, arr
                    add $t1, $t1, $s0
                    lw $t1, 0($t1)

                    # update table[i] to arr[start]
                    la $t2, table
                    add $t2, $t2, $s1
                    sw $t1, 0($t2)

            next_cycle1:
                # set s3 to 40 * j
                mul $s3, $s4, 40
                addi $s4, $4, 1 # increment j
                ble $s3, 400, perm_loop1 #if id < 400, repeat loop

        # ----------- end of first run of algorithm for permutation 1 ------------

        # ----------- start of second run of algorithm for permutation 2 ------------

        # iterate through each cycle in permutation 2

        # $s0 ->  To store initial value of s3 in the beginning of each cycle
        # $s1 -> i (to iterate over hash table entry) 
        # $s2 -> incrementing variable for hashtable storage
        # $s3 -> incrementing variable for array(arr) storage -> id
        # $s4 -> j, which will be used to increment $s3 by 40 * j to move to next cycle
        
        li $s1, 0 #initializing i = 0
        li $s2, 0 #array incrementing pointer

        # loop through elements of hash table - second run for permutation 2
        hashtable_loop2: 
            # load table[i] into $t0
            la $t0, table
            add $t0, $t0, $s1
            lw $t0, 0($t0)

            # iterate through permutation 1

            li $s3, 0 #array incrementing pointer
            li $s4, 0 #initializing j = 1

            # loop through permutation
            perm_loop2:
                move $s0, $s3 # store initial value of s3
        
                # load arr[id] into $t1
                la $t1, arr
                add $t1, $t1, $s3
                lw $t1, 0($t1)

                # check if arr[id] == table[i]
                beq $t1, $t0, found2 #if yes, go to found

                addi $s3, $s3, 4 #incrementing variable for array storage

                # if arr[id] == -1, then move to next cycle by increasing pointer to 40 * j
                beq $t1, -1, next_cycle2 #if yes, go to next_cycle

                b perm_loop2
            
            found:
                # update table[i] to arr[id+1] if arr[id+1] !=1, else arr[start_of_cycle]
                la $t1, arr
                add $t1, $t1, $s3
                lw $t1, 0($t1)

                addi $t1, $t1, 1 # increment arr[id+1]

                # check if arr[id+1] == -1
                beq $t1, -1, reset2 #if yes, reset to 0

                # else update table[i] to arr[id+1]
                la $t2, table
                add $t2, $t2, $s1
                sw $t1, 0($t2)

                reset2: 
                    la $t1, arr
                    add $t1, $t1, $s0
                    lw $t1, 0($t1)

                    # update table[i] to arr[start]
                    la $t2, table
                    add $t2, $t2, $s1
                    sw $t1, 0($t2)

            next_cycle2:
                # set s3 to 40 * j
                mul $s3, $s4, 40
                addi $s4, $4, 1 # increment j
                ble $s3, 400, perm_loop2 #if id < 400, repeat loop


        # now, we have the product permutation in the hash table
        # we need to convert it to cyclic form


        li $v0, 10
        syscall #exit
