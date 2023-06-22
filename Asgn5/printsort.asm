#Name: Zaid Serrano

.globl main
main:
	#char str[]?
	li s0, 1 #loopcontinue = 1/true
	while:
		#li s0, 1 #loopcontinue = 1/true
		beqz s0, endwhile
		la a0, msg1 
		jal printstring
		la a0, str 	#load address of str in a0 for readstring
		jal readstring
		#check if enter key (\n) is pressed (start of str is \n)
		if:
			li t0, 10 
			lb t6, str
    			bne t6, t0, endif
    			li s0, 0
    			b while
    		endif:
			la a0, msg2
			jal printstring	  #print msg2
			la a0, str
			jal printstring  #print original word
			la a0, msg3
			jal printstring	  #print msg3
			#sorting str 
			li t0, 48	#t0 = i
			li t2, 123	#loop runs until i = 123
			li t3, 20	#nested loop runs until we read 20 letters
			#la s1, str	#store str address in regsiter for sorting
			for:
			li t1, 0	#j = 0
			la s1, str	#store str address in regsiter for sorting
			bge t0, t2 forend
			nestedLoop:
			bge t1, t3 nestedLoopEnd
			addi t1, t1, 1	#j++
				if1:
				lb s2, (s1) #store letter at index s1 to s2
				li t4, '\n'
				beq s2, t4, break
				b elseIf
				break:
				addi t0, t0, 1
				#addi s1, s1, 1 #move to next location/letter in str
				b for
				elseIf:
				beq s2, t0 printChar 
				addi s1, s1, 1 #move to next location/letter in str
				b nestedLoop
				printChar:
				mv a0, s2
				jal printchar
				addi s1, s1, 1 #move to next location/letter in str
				b nestedLoop
			nestedLoopEnd:
			addi t0, t0, 1
			b for	
			forend:
			li a0, '\n'
			jal printchar
			b while
				
	endwhile:
	la a0, exit
	jal exit0


.data
msg1: .string "Enter word: "
msg2: .string "Original word: "
msg3: .string "Alphabetized word: "
exit: .string "\nExiting"
##.align 2 # idk what this does extactly
str: .space 20 #str will store chars which are just one bit each.
