.data  # Data and inputs.
n01:	.word 7,n02  # Store 7 and the address of the second node.
n04:	.word 8,0  # Value 8, end of list.
n02:	.word 11,n03  # Store 11 and the address of the third node.
n03:	.word -2,n04  # Store -2 and the address of the fourth node.
lista:	.word n01  # Pointer to the first node.
.text  # Start of the program.
	li a0,0  # Start the node count in a0 at zero.
	lw x11,lista  # Load the address of the first node.
	ori x17,x0,1  # Prepare to print an integer.
check:  # Check for the end of the list.
	beq x11,x0,stop  # Stop when the pointer is null (0).
	addi x10,x10,1  # Count the current node in x10 (a0).
	lw x11, 4(x11)  # Load the next pointer at offset 4.
	beq x0,x0,check  # Jump back because x0 always equals itself.
stop: 	ecall  # At stop, print the final count in x10 (a0).
	ori x17,x0,10  # Prepare to exit the program.
	ecall  # Exit.

# Follows next pointers until a null pointer and counts the nodes.
# Expected output: 4

# Worked example
# 7 -> 11 -> -2 -> 8 -> null. Count one per node -> 4.
