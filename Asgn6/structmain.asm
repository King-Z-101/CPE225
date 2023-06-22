.globl main

.data

#studentNode studentlist[SIZE] = {
#                {"Dougy", 13, 2122},
#                {"Timmy", 15, 2122},
#                {"Emily", 18, 2123},
#                {"Jimmy", 14, 2120},
#                {"Kimmy", 11, 2123},
#                {"Carlo", 19, 2123},
#                {"Vicky", 22, 2120},
#                {"Anton", 12, 2322},
#                {"Brady", 10, 2120},
#                {"Sonya", 16, 2123}
#            };

studentlist:
        .string "Dougy"
        .word   13
        .word   2122
        .string "Timmy"
        .word   15
        .word   2122
        .string "Emily"
        .word   18
        .word   2123
        .string "Jimmy"
        .word   14
        .word   2120
        .string "Kimmy"
        .word   11
        .word   2123
        .string "Carlo"
        .word   19
        .word   2123
        .string "Vicky"
        .word   22
        .word   2120
        .string "Anton"
        .word   12
        .word   2322
        .string "Brady"
        .word   10
        .word   2120
        .string "Sonya"
        .word   16
        .word   2123

.text

#int main() {
main:
    li  sp, 0x7ffffe00
#    int n = SIZE;

#    selectionSort(studentlist, 0, n);
    la  a0, studentlist
    mv  a1, zero
    li  a2, 10
    jal selectionSort

#   printArray(studentlist, n);
    la  a0, studentlist
    li  a1, 10
    jal printArray

#    return 0;
    li  a7, 10
    ecall
#}