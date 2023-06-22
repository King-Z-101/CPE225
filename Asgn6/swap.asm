.globl swap
.globl selectionSort

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap:
# swap callee setup goes here
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

    ret
#}