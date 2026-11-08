.data  # Data and inputs.
	list:.word node0  # Pointer to the first node.
	node0:.word 4,node1  # Value 4, next is node1.
	node1:.word -2,node2  # Value -2, next is node2.
	node2:.word 3,node3  # Value 3, next is node3.
	node3:.word 4,node4  # Value 4, next is node4.
	node4:.word 4,node5  # Value 4, next is node5.
	node5:.word 3,node6  # Value 3, next is node6.
	node6:.word 1,0  # Value 1, end of list.
.text  # Start of the program.
	li a0,0  # Start the running sum at zero.
	lw t0,list  # Load the pointer to the node at index 0.
	beq t0,zero,end  # Finish immediately if the list is empty.
	lw t0,4(t0)  # Skip index 0.
	beq t0,zero,end  # Finish if the list has no node at index 1.
	loop:  # Start of the loop over odd positions.
	lw t1,0(t0)  # Read the value at the current odd index.
	add a0,a0,t1  # Add that value to the sum.

	lw t0,4(t0)  # Step to the next even index.
	beq t0,zero,end  # Finish if there is no following node.
	lw t0,4(t0)  # Step to the next odd index.
	bne t0,zero, loop  # Repeat if that odd-indexed node exists.
end:  # Print the sum of the odd-indexed values.
	li a7,1  # Prepare to print an integer.
	ecall  # Print the number in a0.
	li a7,10  # Prepare to exit the program.
	ecall  # Exit.

# Adds values at zero-based positions 1, 3, 5, and so on.
# Expected output: 5

# Worked example
# Indices 1, 3, 5 -> values -2, 4, 3 -> sum 5.
