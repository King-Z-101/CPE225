#Name: Zaid Serrano, Bryce Uota

.globl swap
.globl selectionSort
.globl printArray


#/* Recursive function to perform selection sort on subarray `arr[i…n-1]` */
#void selectionSort(studentNode arr[], int i, int n) {
selectionSort:
#callee setup goes here
	addi sp, sp -16
    
#    /* find the minimum element in the unsorted subarray `[i…n-1]`
#    // and swap it with `arr[i]`  */
#    int j;
	li t0, 0 # j
#    int min = i;
	mv t1, a1 # min
#    for (j = i + 1; j < n; j++)    {
	addi t0, a1, 1

forloop1:
	# j < n
	bge t0, a2, endfor1
	
	li t2, 16
	mul t3, t0, t2
	add t4, a0, t3 # arr[j]
	lw t5, 8(t4)
	
	li t2, 16
	mul t3, t1, t2
	add t4, a0, t3 # arr[min]
	lw t6, 8(t4)	

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j].studentid < arr[min].studentid) {
	blt t5, t6, if1
	b endif1
if1:
	mv t1, t0
	b endif1

#            min = j;    /* update the index of minimum element */


#        }
endif1:
	addi t0, t0, 1 # j++
	b forloop1


endfor1:
#    }
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#caller setup goes here
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)
	sw a2, 12(sp)
	
	mv a0, a0 # a0 = arr
	mv a2, a1 # a2 = i
	mv a1, t1 # a1, min

	jal swap

#caller teardown goes here (if needed)
	lw ra, 0(sp)
	lw a0, 4(sp)
	lw a1, 8(sp)
	lw a2, 12(sp)
	
	addi a1, a1, 1
	blt a1, a2, if2
	b endif2
 
#    if (i + 1 < n) {
if2:

#caller setup goes here
	sw ra, 0(sp)

#        selectionSort(arr, i + 1, n);
	jal selectionSort

#caller teardown goes here (if needed)
	lw ra, 0(sp)
	b endif2
#    }
endif2:
    
#callee teardown goes here (if needed)
	addi sp, sp, 16
	ret
#}

#}

printArray:            # void printArray(studentNode arr[], int n)
for2:                # for (i = 0; i < n; i++)
    li t1, 0        # t1 = i = 0
    mv t6, a0      
forloop2:            
    bge t1, a1, endfor2   

    li t4, 12
    mul t5, t1, t4

    mv t2, t1        # student id
    slli t2, t2, 2  
    addi t2, t2, 8       
    add t2, t2, t5        
    add t2, t2, t6        
    lw a0, (t2)        
    li a7, 1        
    ecall

    li a0, ' '
    li a7, 11
    ecall

    mv t2, t1        #print name
    slli t2, t2, 2      
    add t2, t2, t5        
    add t2, t2, t6       
    mv a0, t2
    li a7, 4       
    ecall

    li a0, ' '
    li a7, 11
    ecall

    mv t2, t1        # coursenum
    slli t2, t2, 2  
    addi t2, t2, 12  
    add t2, t2, t5     
    add t2, t2, t6 
    lw a0, (t2)       
    li a7, 1       
    ecall

    li a0, '\n'
    li a7, 11
    ecall

    addi t1, t1, 1 
    b forloop2
endfor2:
    ret



#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
#caller setup goes here
	#a0 = start of array
	#a1 = i = min(number)
	#a2 = j = i (number)
	#copy of start address of arr[] for later use
	mv t0, a0	 
	mv t2, a0
	#acessing arr[i]
	slli t1, a1, 4
	add t0, t0, t1 
	#testing
	#lw t1, 8(t0)
	#mv a0, t1
	#li a7, 1
	#ecall
	#acessing arr[j]
	slli t1, a2, 4
	add t2, t2, t1
	#testing
	#lw t1, 8(t2)
	#mv a0, t1
	#li a7, 1
	#ecall

#    studentNode temp = arr[i];
	#store string arr[i] into two registers
	lw t1, 0(t0)
	lw t3, 4(t0)
	#store int arr[i] into one registers
	lw t4, 8(t0)
	#store int arr[i] into one registers
	lw t5, 12(t0)


#    arr[i] = arr[j];
	#string
	lw a1, 0(t2)
	lw a2, 4(t2)
	#int
	lw a3, 8(t2)
	#int
	lw a4, 12(t2)
	#move t2/arr[j] values to arr[i]
	sw a1, 0(t0)
	sw a2, 4(t0)
	sw a3, 8(t0)
	sw a4, 12(t0)
	  

#    arr[j] = temp;
	sw t1, 0(t2) 
	sw t3, 4(t2)
	sw t4, 8(t2)
	sw t5, 12(t2)
#caller teardown goes here
	#lw t1, 8(t0)
	#mv a0, t1
	#li a7, 1
	#ecall
	
	#lw t1, 8(t2)
	#mv a0, t1
	#li a7, 1
	#ecall

	ret 
#}