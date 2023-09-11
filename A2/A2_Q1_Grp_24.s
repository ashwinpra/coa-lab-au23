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
    print_prompt: 
        .asciiz "Result in cycle notation: "
    cycle_prompt1:
        .asciiz "Enter elements in cycle " 
    cycle_prompt2: 
        .asciiz " (Terminate cycle input by entering -1): "
    newline: 
        .asciiz "\n"
    open_braces: 
        .asciiz "("
    close_braces:
        .asciiz ")"
    comma:
        .asciiz ", "
    
    .align 4
    arr:
        .space 400 # max 10 elements * 10 max arrays = 400

    .align 4
    table:
        .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 # hash table to store elements

    .align 4 
    visited: 
        .space 40 # max 10 elements * 4 bytes = 40 bytes

.text 
    .globl main

    # $s4 -> No. of cycles in permutation 1
    # $s5 -> No. of cycles in permutation 2
    # $t1 -> i (to iterate over array)
    # $s1 -> j (to iterate over cycles)

    main: 

        perm_1_input: 
            li $v0, 4
            la $a0, ip_prompt1
            syscall #prompt user to input no. of cycles in permutation 1

            li $v0, 5
            syscall 
            move $s4, $v0 #taking input of no. of cycles

            li $t1, 0 #initializing i = 0 (for array storage)
            li $s1, 1 #initializing j = 1 (for no. of cycles)

            la $t2, arr # t2 -> temp variable for storing address of array

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

                cycle_input_loop1:

                    sll $t4, $t1, 2
                    add $t4, $t4, $t2 # t4 -> &arr[i]

                    li $v0, 5
                    syscall

                    sw $v0, ($t4) # storing arr[i] in arr

                    beq $v0, -1, exit_cycle_input_loop1 #if yes, exit loop

                    addi $t1, $t1, 1 # incrementing i

                    j cycle_input_loop1

                exit_cycle_input_loop1:
                    mul $t1, $s1, 10 # set t1 to 10 * j to move to next array
                    addi $s1, $s1, 1 # increment i
                    ble $s1, $s4, input_loop1 #if i < no. of cycles, repeat 
                

        perm_2_input:
            # here we will set t1 to 50 to store the second permutation
            li $t1, 50

            li $v0, 4
            la $a0, ip_prompt2
            syscall #prompt user to input no. of cycles in permutation 2

            li $v0, 5
            syscall 
            move $s5, $v0 #taking input of no. of cycles

            li $s1, 1 #initializing j = 1 again
    
            # loop for each cycle
            input_loop2:
                li $v0, 4
                la $a0, cycle_prompt1
                syscall #prompt user to input cycle

                li $v0, 1
                move $a0, $s1
                syscall #print cycle no.

                li $v0, 4
                la $a0, cycle_prompt2
                syscall #tell them to terminate cycle input by entering -1

                cycle_input_loop2:

                    sll $t4, $t1, 2
                    add $t4, $t4, $t2 # t4 -> &arr[i]

                    li $v0, 5
                    syscall

                    sw $v0, ($t4) # storing arr[i] in arr

                    beq $v0, -1, exit_cycle_input_loop2 #if yes, exit loop

                    addi $t1, $t1, 1 # incrementing i

                    j cycle_input_loop2

                exit_cycle_input_loop2:
                    addi $s2, $s1, 5 # to move to 2nd half of array (j+5) used
                    mul $t1, $s2, 10 # set t1 to 10 * j to move to next array
                    addi $s1, $s1, 1 # increment i
                    ble $s1, $s5, input_loop2 #if i < no. of cycles, repeat 



        algorithm:
            # iterate through each cycle in permutation 1

            li $t1, 0 #initializing i = 0 (for access of table)
            li $t2, 0 #initializing j = 0 (for access of arr - 1st permutation)
            li $s1, 1 #initializing k = 1 (for no. of cycles)

            la $t3, arr # t2 -> temp variable for storing address of array # $t2 
            la $t4, table # t3 -> temp variable for storing address of hash table # $t3

            perm_1_update: 
                sll $t5, $t1, 2
                add $t5, $t5, $t4 # t5 -> &table[i]

                move $t6, $t1 # t6 -> i

                # now search for i in arr
                search_arr1:
                    sll $t7, $t2, 2
                    add $t7, $t7, $t3 # t7 -> &arr[j]

                    lw $t8, ($t7) # t8 -> arr[j]

                    beq $t8, $t6, found1 #if yes, go to found

                    addi $t2, $t2, 1 # increment j

                    beq $t8, -1, move_cycle1 # on end of current cycle, move to next cycle

                    j search_arr1

                found1:
                    # update table[i] to arr[j+1] if arr[j+1] != -1, else arr[start_of_cycle]

                    addi $t2,$t2, 1 # increment j

                    sll $t7, $t2, 2
                    add $t7, $t7, $t3 # t7 -> &arr[j]

                    lw $t8, ($t7) # t8 -> arr[j]

                    # check if arr[j+1] == -1
                    beq $t8, -1, reset1 #if yes, reset to 0

                    # else update table[i] to arr[j+1]
                    sw $t8, ($t5)
                    
                    j reset_search1

                    reset1: 
                        # index of start of cycle found from s1
                        addi $s2, $s1, -1
                        mul $t7, $s2, 40
                        add $t7, $t7, $t3
                        lw $t8, ($t7)

                        # update table[i] to arr[start]
                        sw $t8, ($t5)

                        j reset_search1

                move_cycle1:
                    mul $t2, $s1, 10 # set t2 to 10 * k to move to next array
                    addi $s1, $s1, 1 # increment k
                    ble $s1, $s4, search_arr1 #if k < no. of cycles, repeat

                    j reset_search1 #if k > no. of cycles, reset search

                reset_search1:  
                    addi $t1, $t1, 1 # increment
                    bge $t1, 10, perm_2_update_start # add next step here

                    li $t2, 0 #reinitializing j = 0 for new search
                    li $s1, 1 #reinitializing k = 1 for new search

                    j perm_1_update

            # iterate through each cycle in permutation 2

            perm_2_update_start:
                li $t1, 0 #initializing i = 0 (for access of table)
                li $t2, 50 #initializing j = 50 (for access of arr - 2nd permutation)
                li $s1, 1 #initializing k = 1 (for no. of cycles)

                la $t3, arr # t2 -> temp variable for storing address of array # $t2 
                la $t4, table # t3 -> temp variable for storing address of hash table # $t3

            perm_2_update: 
                sll $t5, $t1, 2
                add $t5, $t5, $t4 # t5 -> &table[i]

                lw $t6, ($t5) # t6 -> table[i]


                # now search for table[i] in arr
                search_arr2:
                    sll $t7, $t2, 2
                    add $t7, $t7, $t3 # t7 -> &arr[j]

                    lw $t8, ($t7) # t8 -> arr[j]

                    beq $t8, $t6, found2 #if yes, go to found

                    addi $t2, $t2, 1 # increment j

                    beq $t8, -1, move_cycle2 # on end of current cycle, move to next cycle

                    j search_arr2

                found2:
                    # update table[i] to arr[j+1] if arr[j+1] != -1, else arr[start_of_cycle]

                    addi $t2,$t2, 1 # increment j

                    sll $t7, $t2, 2
                    add $t7, $t7, $t3 # t7 -> &arr[j]

                    lw $t8, ($t7) # t8 -> arr[j]

                    # check if arr[j+1] == -1
                    beq $t8, -1, reset2 #if yes, reset to 0

                    # else update table[i] to arr[j+1]
                    sw $t8, ($t5)

                    j reset_search2
                    

                    reset2: 
                        # index of start of cycle found from s1
                        addi $s2, $s1, 4
                        mul $t7, $s2, 40
                        add $t7, $t7, $t3
                        lw $t8, ($t7)

                        # update table[i] to arr[start]
                        sw $t8, ($t5)
                        
                        j reset_search2

                move_cycle2:
                    addi $s2, $s1, 5 # to move to 2nd half of array (k+5) used
                    mul $t2, $s2, 10 # set t2 to 10 * k to move to next array
                    addi $s1, $s1, 1 # increment k
                    ble $s1, $s5, search_arr2 #if k < no. of cycles, repeat

                    j reset_search2 #if k > no. of cycles, reset search

                reset_search2:
                    addi $t1, $t1, 1 # increment
                    bgt $t1, 10, print_result 

                    li $t2, 50 #reinitializing j = 50 for new search
                    li $s1, 1 #reinitializing k = 1 for new search

                    j perm_2_update

        print_result:
            la $a0, print_prompt
            li $v0, 4
            syscall
            
        find_cyclic: 
            li $t0,0  #t0 -> i
            la $t9, visited
            la $t8, table

            cyclic_loop:
                beq $t0,10,exit # stop when i==10

                # load visited[i] in t2
                sll $t1,$t0,2
                add $t1,$t1,$t9
                lw $t2,($t1)

                beq $t2,1,increment_i  # increment if visited[i]==1

                #load table[i] in t2
                sll $t1,$t0,2
                add $t1,$t1,$t8
                lw $t2,($t1)  

                beq $t2,$t0,increment_i  # increment if table[i]==i
                
                # else, start printing cycles
                la $a0,open_braces  
                li $v0,4
                syscall # print "("

                move $a0,$t2  
                li $v0,1
                syscall # print table[i]

                la $a0,comma
                li $v0,4
                syscall # print ","

                sll $t1,$t2,2
                add $t1,$t1,$t9
                li $t6,1
                sw $t6,($t1) #visited[table[i]] is set as 1

                sll $t1,$t0,2
                add $t1,$t1,$t9
                li $t6,1
                sw $t6,($t1) #visited[i] is set as 1
            
            # loops till entire cycle is printed
            cyclic_loop1:  
    
                # set t2 to table[t2]
                sll $t1,$t2,2
                add $t1,$t1,$t8
                lw $t2,($t1)

                move $a0,$t2 
                li $v0,1
                syscall # print table[i]

                # load value of visited[table[i]] in t3
                sll $t1,$t2,2
                add $t1,$t1,$t9
                lw $t3,($t1)

                beq $t3,1,increment_i1  #if visited[table[i]]==1 ( means that we have printed the entire cycle, and we are back in 1st element, then increment i and start printing new cycle)

                # visited [t2] is set as 1
                sll $t1,$t2,2
                add $t1,$t1,$t9
                li $t6,1
                sw $t6,($t1)

                la $a0,comma  
                li $v0,4
                syscall # print ","

                b cyclic_loop1
            
            increment_i1:  # incrementing i and starting new cycle in inner loop
                # set visited[i] as 1
                sll $t1,$t0,2
                add $t1,$t1,$t9
                li $t6,1
                sw $t6,($t1)

                addi $t0,$t0,1 # increment i

                la $a0,close_braces 
                li $v0,4
                syscall # print ")"

                b cyclic_loop # start printing new cycle
            
            increment_i:  # incrementing i and starting new cycle in outer loop (singleton cases)
                # set visited[i] as 1
                sll $t1,$t0,2
                add $t1,$t1,$t9
                li $t6,1
                sw $t6,($t1)

                addi $t0,$t0,1 # increment i

                b cyclic_loop # start printing new cycle

        exit: 
            li $v0, 10
            syscall #exit