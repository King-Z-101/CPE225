#ecall test script

.text
.globl main
main:
	#stinkup the caller save registers
	li a0, -1
	li a1, -1
	li a2, -1
	li a3, -1
	li a4, -1
	li a5, -1
	li a6, -1
	li a7, -1
	li t0, -1
	li t1, -1
	li t2, -1
	li t3, -1
	li t4, -1
	li t5, -1
	li t6, -1

	#preload the callee save registers to check later.
	li s0, -1
	li s1, -1
	li s2, -1
	li s3, -1
	li s4, -1
	li s5, -1
	li s6, -1
	li s7, -1
	li s8, -1
	li s9, -1
	li s10, -1
	li s11, -1

	la	a0, startmsg
	jal	printString


	jal	printCharTest

	jal 	readCharTest
	jal 	readStringTest
	
	jal	printIntTest
	jal 	readIntTest
	b	done	# once printstring works, move this line down by one.
done:
	jal	regCheck
	jal 	exitProgram

#should not reach this line 
	li		a7, 93
	li		a0, -1
	ecall

.data
startmsg:	.string "starting mecall test"
promptstr:	.string	"\nType a string and press enter: "
response:	.string	"\nYou typed :"
printintmsg1:	.string	"\nPrinting the number 4. The number is:"
printintmsg2:	.string	"\nDid you see number 4 printed?"
readintmsg1:	.string	"\nEnter the number '9' : "
readintpassmsg:	.string	"\nreadInt passed. The number 9 detected."
readintfailmsg:	.string	"\nreadInt failed. The number 9 not detected."
promptchar:	.string	"\nEnter the letter 'z': "
readcharpass:	.string	"\nreadChar passed. The letter z detected."
readcharfail:	.string	"\n readChar fails. The letter z was not typed."
printcharmsg:	.string "\nLets print the letter 'a' : "
printcharmsg2:	.string	"\nDid you see the letter 'a' get printed?"
regerrmsg:		.string "\nCallee Save registers corrupted"
regpassmsg:		.string "\nCallee Save register check passes"
respint:	.word 0
respchar:	.byte '\0'
respstr:	.space 20

.text

readStringTest: #8
	addi	sp, sp, -16
	sw 	ra, 12(sp)
	la 	a0, promptstr
	jal 	printString
	la 	a0, respstr
	jal 	readString
	la 	a0, response
	jal 	printString

	la 	a0, respstr
	jal 	printString
	lw 	ra, 12(sp)
	addi	sp, sp, 16
	ret
	
printCharTest: #11
	addi	sp, sp -16
	sw 	ra, 12(sp)
	la 	a0, printcharmsg
	jal 	printString
	li 	a0, 'a'
	jal 	printChar
	lw 	ra, 12(sp)
	addi	sp, sp, 16
	ret
	
readCharTest: #12
	addi	sp, sp, -16
	sw 	ra, 12(sp)
	sw 	s0, 8(sp)

	la 	a0, promptchar
	jal 	printString

	jal 	readChar
	li		t0, 'z'
	bne	a0, t0, notz
	la 	a0, readcharpass
	jal 	printString
	b		endreadCharTest
notz:
	la 	a0, readcharfail
	jal 	printString
endreadCharTest:
	lw 	s0, 8(sp)
	lw 	ra, 12(sp)
	addi	sp, sp, 16
	ret

	
printIntTest: #11
	addi	sp, sp -16
	sw 	ra, 12(sp)
	la 	a0, printintmsg1
	jal 	printString
	li 	a0, 4
	jal 	printInt
	la 	a0, printintmsg2
	jal 	printString
	lw 	ra, 12(sp)
	addi	sp, sp, 16
	ret
	
readIntTest: #12
	addi	sp, sp, -16
	sw 	ra, 12(sp)
	la 	a0, readintmsg1
	jal 	printString
	jal	readInt
	li		t0, 9
	bne	a0, t0, not9
	la 	a0, readintpassmsg
	jal 	printString
	b		endreadIntTest
not9:
	la 	a0, readintfailmsg
	jal 	printString
endreadIntTest:
	lw 	ra, 12(sp)
	addi	sp, sp, 16
	ret

regCheck:
#break callee save register usage rules because I'm the boss.
	addi	sp, sp -16
	sw 	ra, 12(sp)
	li a0, -1
	bne	s0, a0, regerror
	bne	s1, a0, regerror
	bne	s2, a0, regerror
	bne	s3, a0, regerror
	bne	s4, a0, regerror
	bne	s5, a0, regerror
	bne	s6, a0, regerror
	bne	s7, a0, regerror
	bne	s8, a0, regerror
	bne	s9, a0, regerror
	bne	s10, a0, regerror
	bne	s11, a0, regerror
	la		a0, regpassmsg
	jal	printString
	b		endregcheck

regerror:
	la		a0, regerrmsg
	jal	printString
endregcheck:
	lw 	ra, 12(sp)
	addi	sp, sp 16
	ret
	
	
