@ ARM Assembly - lab 3.2 
@ Group Number : 29

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	

mol: 					

condition:
	CMP r0, r1				//compare r0 with r1
	BGE loop				//(if r0 >= r1) go to loop

	MOV pc, lr			

loop:
	SUB r0, r0, r1			//r0 = r0 - r1
	B condition				//again go to condition


@ ---------------------	
gcd:
	SUB sp, sp, #4			// Adjust stack for 1 items
	STR lr, [sp, #0]		// Save lr in stack

	CMP r1, #0				//compare r1 with 0
	BNE then				//if r1 != r0; go to then

	ADD sp, sp, #4			// pop 1 items from stack

	MOV pc, lr				//return

then:
	MOV r6, r1				//temp r6 = r1 = 0;
	;SUB sp, #4
	;STR r1, [sp,#0]
	
	BL mol						//go to mol function		//return value in r0 = (r0 % r1)
	
	MOV r1, r0					//r1 = r0
	MOV r0, r6					//r0 = r6 = r1
	;LDR r0, [sp,#0] ;r0=r1
	;ADD sp, #4

	BL gcd					//go to gcd function
	LDR lr, [sp, #0]		//Restore
	ADD sp, sp, #4			//pop 1 items from stack
	MOV pc, lr				//Return

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64	@the value a
	mov r5, #24	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
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
format: .asciz "gcd(%d,%d) = %d\n"

