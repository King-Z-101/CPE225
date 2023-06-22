.globl printstring readstring printchar readchar exit0

printstring:
    li a7, 4     # putting 4 into a7 is printstring
    ecall        # issue the system call to print the string
    ret

readstring:
    #li t0, 0    #ch = 0
    sw ra, readstringRA, t1		#ra of readstring is pointing/stored to location readstringRA
    #sw a0, (t2)				#storing a0/address of str space in main to t2
    mv t1, a0				#moving a0/str startto t1 
    do:
        #mv t1, a0			#a0 stores the start of str	
        jal readchar
        mv t2, a0
        sb  t2, (t1)
        addi t1, t1, 1
        b while
    while: 
        li t3, 10    #\n = 10 in ascii
        beq t2, t3 endwhile
        b do
    endwhile:
        li t4, '\0'    #\0 is 3 in ascii?
        sb t4, (t1)     #put \0 at the end of the string
        mv a0, t2    #move a1 to a0 to be returned
        lw  ra, readstringRA
        ret

printchar:
    li a7, 11     #11 = printchar
    ecall
    ret
readchar:
    li a7, 12     #12 = readchar
    ecall
    ret

exit0:
    jal ra, printstring
    li a7, 10  # Again we need to indicate what system call we are making and this time we are calling exit(93)
    ecall
.data
exit: .string "\nExiting\n"
str: .space 20 #str will store chars which are just one bit each.
readstringRA: .word -1
