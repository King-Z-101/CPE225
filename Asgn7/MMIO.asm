.globl printInt printString printChar readChar readInt exitProgram readString
printInt:
	addi sp, sp, -16
	sw ra, 12(sp)
loopPrintInt:
	lw t1, TCR
	lw t0, (t1)
	andi t0, t0, 1
	beq t0, zero, loopPrintInt
	lw t1, TDR
	addi a0, a0, 48
	sw a0, (t1) # write char
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

printString:
	addi sp, sp, -16
	sw ra, 12(sp)
loopPrintString:
	la t0, TDR
	lw t0, 0(t0) # Actual TDR register address: t0
	lb t1, 0(a0) # Char at address. t1
	beq t1, zero, endPrintString # Exits the loop if char is null
	sw t1, 0(t0)
	addi a0, a0, 1
	b loopPrintString
endPrintString:
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

printChar:
	addi sp, sp, -16
	sw ra, 12(sp)
loopPrintChar:
	lw t1, TCR
	lw t0, (t1)
	andi t0, t0, 1
	beq t0, zero, loopPrintChar
	lw t1, TDR
	sb a0, (t1) # write char
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

readChar:
	la t0, RCR 
	lw t0, 0(t0) 	# Pointer to status register
	lw t0, 0(t0) 	# Dereference the pointer
	andi t1, t0, 1 
	beqz t1, readChar
	la t1, RDR 	# Address to pointer
	lw t1, 0(t1) 	# Pointer to data register
	lbu a0, 0(t1) 	# Char typed by keyboard
	ret
	
readInt:
	la t0, RCR 
	lw t0, 0(t0) 	# Pointer to status register
	lw t0, 0(t0) 	# Dereference the pointer
	andi t1, t0, 1 
	beqz t1, readInt
	la t1, RDR 	# Address to pointer
	lw t1, 0(t1) 	# Pointer to data register
	lw t2, 0(t1) 	# Int typed by keyboard
	addi a0, t2, -48
	ret
		
readString:
	addi sp, sp, -16
	sw ra, 12(sp) 			#Store ra of readString subroutine
	mv t0, a0			# t0 is the address of string
readStringWhile:
    	sw t0, 8(sp)			# Saves the string address before jal
        jal readChar
        lw t0, 8(sp)			# Restores string address
        li t1, '\n'	
        beq a0, t1, endReadString	# Checks to see if user entered enter key.
        sb a0, 0(t0)			# Stores key pressed to location in memory
        addi t0, t0, 1			# Address offsetted by 1
        b readStringWhile
endReadString:	
	sb zero, 0(t0)			# Adds null to the end.
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# Old readString
#addi sp, sp, -16
#sw ra, 12(sp) 		#Store ra of readString subroutine
#mv t1, a0				#moving a0/str startto t1 
#do:
        #mv t1, a0			#a0 stores the start of str	
#jal readChar
#mv t2, a0
#sb  t2, (t1)
#addi t1, t1, 1
#b while
#while: 
#li t3, 10    #\n = 10 in ascii
#beq t2, t3 endwhile
#b do
#endwhile:
#li t4, '\0'    #\0 is 3 in ascii?
#sb t4, (t1)     #put \0 at the end of the string
#mv a0, t2    #move a1 to a0 to be returned
#lw ra, 12(sp)
#la t1, RDR 
#lw t1, 0(t1)
#sw a0, 0(t1)
#addi sp, sp, 16
#ret
	
exitProgram:
	jal ra, printString
	li a7, 10  # Again we need to indicate what system call we are making and this time we are calling exit(93)
	ecall

.data
RCR: .word 0xFFFF0000
RDR: .word 0xFFFF0004
TCR: .word 0xFFFF0008
TDR: .word 0xFFFF000c
