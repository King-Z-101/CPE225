.globl main
#int main() {
main:
        li      sp, 0x7ffffe00
        addi    sp, sp, -48
        sw      ra, 44(sp)
        sw      s0, 40(sp)


#   int arr[SIZE] = { 3, 5, 8, 4, 1, 9, -2, 2, 0, 6 };
        li      t0, 3
        sw      t0, 0(sp)
        li      t0, 5
        sw      t0, 4(sp)
        li      t0, 8
        sw      t0, 8(sp)
        li      t0, 4
        sw      t0, 12(sp)
        li      t0, 1
        sw      t0, 16(sp)
        li      t0, 9
        sw      t0, 20(sp)
        li      t0, -2
        sw      t0, 24(sp)
        li      t0, 2
        sw      t0, 28(sp)
        li      t0, 0
        sw      t0, 32(sp)
        li      t0, 6
        sw      t0, 36(sp)

#   int n = SIZE;
        li      s0, 10

#    selectionSort(arr, 0, n);
        mv      a0, sp
        mv      a1, zero
        mv      a2, s0
        jal     selectionSort

#    printArray(arr, n);
        mv      a0, sp
        mv      a1, s0
        jal printArray

#    return 0;
        lw      ra, 44(sp)
        lw      s0, 40(sp)
        addi    sp, sp, 48
        addi    a7, x0, 10
        ecall


######################################################################v
#void printArray(int arr[], int n) {
printArray:
        addi    sp, sp, -16
        sw      ra, 12(sp)
        sw      s0, 8(sp)
        sw      s1, 4(sp)
        sw      s2, 0(sp)
        mv      s0, a0
        mv      s1, a1

#    int i; #allocate to t0 register

#    for (i = 0; i < n; i++) {
for:
        mv  s2, x0

# i < n;
forloop:
        bge     s2, s1 endfor

#   printf("%d ", arr[i]);

        slli    t0, s2, 2  # multiply index by 4
        add     t1, s0, t0 # add full index to base address.
        lw      a0, 0(t1)  # load arr[i]

        li      a7, 1
        ecall              #print the number

        li      a0, 0x20
        li      a7, 11
        ecall              # print a space

#i++
        addi    s2, s2, 1  # increment i
        b       forloop
#    }
endfor:

#return from void function
        lw      ra, 12(sp)
        lw      s0, 8(sp)
        lw      s1, 4(sp)
        lw      s2, 0(sp)
        addi    sp, sp, 16
        ret
#}