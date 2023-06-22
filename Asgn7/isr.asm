 # Kevin Yuan
# Zaid Serrano
.text
.globl initialization 

initialization:
addi sp, sp, -16
sw ra, 12(sp)
la t0, handler
csrrw zero, utvec, t0	# Utvec gets address to handler
li t1, 0x00000100
csrrs zero, uie, t1	# Enable receiving of device interrupt
				
lw t0, RCR
lw t1, (t0)
ori t1, t1, 2   	# set bit 1 of RCR to 1
sw t1, 0(t0)

csrrsi zero, ustatus, 1	# Enable global interrupt checking ustatus

la a0, IntMsg
jal printString
lw ra, 12(sp)
addi sp, sp, 16
ret

handler:
addi sp, sp, -32
sw ra, 28(sp)
sw t0, 24(sp)
sw t1, 20(sp)
sw t2, 16(sp)

jal readChar		# Takes in what user has pressed
sb a0, 0(sp)		# Stores key in stack
la a0, KeyPressed	# a0 overriden to print prompt
jal printString
lb a0, 0(sp)		# Restores key
jal printChar		
sb a0, 0(sp)
li a0, '\n'		
jal printChar
lb a0, 0(sp)

la t0, counter		
lw t1, 0(t0)
li t2, 5
addi t1, t1, 1
bne t1, t2 skipReset	# Resets only if counter is 5

reset:			# Changes the uepc address to main address. (urets back to beginning of main)
la t2, main
csrrw zero, uepc, t2
li t1, 0
skipReset:		
sw t1, 0(t0)		# Updates the global counter
lw ra, 28(sp)		# Restores registers.
lw t0, 24(sp)
lw t1, 20(sp)
lw t2, 16(sp)
addi sp, sp, 32
uret

.data
IntMsg: .string "\nInitializing Interrupts\n"
KeyPressed: .string "\nKey pressed is: "
RCR: .word 0xFFFF0000
counter: .word 0
