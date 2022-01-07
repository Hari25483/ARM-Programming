@ ARM Assembly - exercise 6 
@ Group Number : 29

	.text 	@ instruction memory
	
	
@ Write YOUR CODE HERE	

@ ---------------------	
		

fact:
	sub sp, sp, #4		// Adjust stack for 1 items
	str r6, [sp,#0]		// Save variable fact in stack
    mov r6,#1   @Start from 1, and then multiply by incrementing the values
    
loop:
    cmp r0,#1		@compare r0 and 1
    blt exit    	@Exit if (n<1)
    mul r7,r6,r0	@r(n)=r(n)* r(n-1)!
    mov r6,r7    	@move r7 to r6 so that the previous multiplied value can be saved and used in the next multiplication process
    sub r0,r0,#1 	@n=n-1
    b loop
    
exit: 
    mov r0,r6   
    ldr r6,[sp,#0]
    add sp,sp,#4
    mov pc,lr
    

@ ---------------------	


.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8 	@the value n

	@ calling the fact function
	mov r0, r4 	@the arg1 load
	bl fact
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
format: .asciz "Factorial of %d is %d\n"

