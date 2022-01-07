@ ARM Assembly - exercise 7 
@ Group Number :29

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
Fibonacci:
	sub sp,sp,#12   	@Allocate 3 stacks in the memory
	str lr,[sp,#0]	    @Store lr in stack.
	str r0,[sp,#4]

	cmp r0,#2			@For the base cases, compare ro with 2. If less than or equal to 2, then return 1
	ble second_call
	
	sub r0,r0,#1		@Implement f(n-1)
	bl Fibonacci
	str r0,[sp,#8] 
	ldr r0,[sp,#4] 
	
	sub r0,r0,#2		@Implement f(n-2)
	bl Fibonacci
	ldr r1,[sp,#8]
	add r0,r0,r1
	ldr lr,[sp,#0]
	@Add stacks and point pc to lr
	add sp,sp,#4	
	add sp,sp,#8
	mov pc,lr  

second_call:
	mov r0,#1		@move 1 to r0 for the base cases and then release the stacks.
	add sp,sp,#8
	add sp,sp,#4
	mov pc,lr		@point to the stack pointer where the program needs to go


@ ---------------------
	
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl Fibonacci
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "F_%d is %d\n"

