.data  # Data and inputs.
	list: .word node1  # Pointer to the first node.
	node1:.word 4,node2  # Value 4, next is node2.
	node2:.word -2,node3  # Value -2, next is node3.
	node3:.word 3,node4  # Value 3, next is node4.
	node4:.word 4,node5  # Value 4, next is node5.
	node5:.word -4,node6  # Value -4, next is node6.
	node6:.word 3,node7  # Value 3, next is node7.
	node7:.word 1 ,0  # Value 1, end of list.
.text  # Start of the program.
	lw t0,list  # Load the list head.
	li a0,0  # Start the sum at zero.
	beqz t0,print  # Print zero immediately if the list is empty.
loop:  # Start of the loop that checks each node.
	lw t1,0(t0)  # Read the node value at offset 0.
	ble t1,zero,end  # Skip values <= 0.
	add a0,a0,t1  # Add the positive value to the sum.
end:  # Move to the next node.
	lw t0,4(t0)  # Load the next pointer at offset 4.
	bne t0,zero,loop  # Repeat if there is another node.
print:  # Print the sum of positive values.
	li a7,1  # Prepare to print an integer.
	ecall  # Print the number in a0.
	li a7,10  # Prepare to exit the program.
	ecall  # Exit.

# Follows the list and adds only values greater than zero.
# Expected output: 15

# Worked example
# [4, -2, 3, 4, -4, 3, 1] -> keep [4, 3, 4, 3, 1] -> sum 15.
