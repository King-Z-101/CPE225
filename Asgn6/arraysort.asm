.globl swap
.globl selectionSort

#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here
	addi sp, sp, -16
	sw ra, 12(sp)		#save ra onto stack (and parameters onto stack
	#sw a0, 8(sp)
	#sw a1, 4(sp)
	sw a2, 0(sp)		#stores n value for recursive calls
    # find the minimum element in the unsorted subarray `[i�n-1]` and swap it with `arr[i]`  */
#    int j;
	li t0, 0


#    int min = i;
	mv t1, a1

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
	addi t2, t1, 1 #i + 1
	add t0, t0, t2
forloop:
# j < n
	bge t0, a2 endfor
	mv t5, a0	#arr for j
	mv t6, a0	#arr for min
	mv a5, t0	#store j value before its used to ascess array
	mv t2, t1	#store min value before its used to ascess array
	slli t0, t0, 2
    	slli t1, t1, 2
	add t5, t5, t0 #going to index location j in arr
	add t6, t6, t1 #going to index location min in arr 



#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1:
	lw t3, (t5)
	lw t4, (t6)
	bge t3, t4 endif1

#            min = j;    /* update the index of minimum element */
	mv t0, a5
	mv t2, t0
	mv t1, t2
	addi t0, t0, 1
	b forloop
#        }
endif1:
	mv t0, a5
	mv t1, t2
	addi t0, t0, 1
	b forloop


#    }
endfor:

#    /* swap the minimum element in subarray `arr[i�n-1]` with `arr[i] */
#    swap(arr, min, i); a0 = arr, a2 = i
	mv a2, a1	#moving the value of i into a2 for swap
	mv a1, t1 
#caller setup and subroutine call for swap goes here.
	jal swap 

#caller teardown for swap goes here (if needed).

#    if (i + 1 < n) {
if2:
	addi t2, a1, 1
	lw a2, 0(sp)
	bge t2, a2 endif2
	mv a1, t2


#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.
	jal selectionSort

#caller teardown for selectionSort goes here (if needed).



#    }
endif2:


# callee teardown goes here
	lw ra, 12(sp)
	addi sp, sp, 16
	ret


#}



#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap:
# swap callee setup goes here
    mv t4, a2	#store i value before its used to access array
    slli a1, a1, 2
    slli a2, a2, 2
    add t0, a0, a1 #arr[i]
    add t1, a0, a2 #arr[j]

#    int temp = arr[i];

    lw t2, (t0)

#    arr[i] = arr[j];

    lw t3, (t1)
    sw t3, (t0)

#    arr[j] = temp;

    sw t2, (t1)

# swap callee teardown goes here
    mv a1, t4
    ret
#}
