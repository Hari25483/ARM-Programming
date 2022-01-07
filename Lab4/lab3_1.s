@ ARM Assembly - lab 3.1
@ Group Number : 29
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	

mypow:
	mov r7,r5;
	SUB sp, sp, #8			// Adjust stack for 2 items (n and x)
	STR r7, [sp, #4]		// Save n in stack
	STR r4, [sp, #0]		// Save x in stack
	
	MOV r4, #1  			// initially PowerValue = 1
	MOV r7, #0  			// count = 0

loop:
	CMP r7, r1				// compare count (r7) with arg2(r1) (r4^r1)
	BGE exit				// if (counter >= n) go to Exit

	MUL r6, r4, r0			// if (counter < n) -> temporary reg r6 = r4 * r0
	MOV r4, r6				// move power value to r4 from r6

	ADD r7, r7, #1 			// increase the count by 1 (count++)
	B 	loop				// again go to loop

exit: 
	MOV r0, r4				// moved Result to r0  (return value register r0)

	LDR r4, [sp, #0]		// Restore r4
	LDR r7, [sp, #4]		// Restore r7
	ADD sp, sp, #8			// pop 2 items from stack
	MOV pc,lr				// Return
	
	
@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "%d^%d is %d\n"

