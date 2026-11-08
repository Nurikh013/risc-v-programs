.data  # Data and inputs.
    list:  .word node1  # Pointer to the first node.
    node1: .word 5, node2  # Value 5, next is node2.
    node2: .word 9, node3  # Value 9, next is node3.
    node3: .word -2, node4  # Value -2, next is node4.
    node4: .word 0, node5  # Store 0 as a value and a pointer to node5.
    node5: .word 7, 0  # Value 7, end of list.
.text  # Start of the program.
	lw s1,list  # Load the list head.
	addi a0,zero,0  # Start the running sum at zero.
beqz s1,print  # If the list is empty, print 0.
loop:  # Node-summing loop.
	lw t0,0(s1)  # Read the node value at offset 0.
	add a0,a0,t0  # Add the node value to the running sum.
	lw s1,4(s1)  # Load the next pointer at offset 4.
	bne s1,zero,loop  # Repeat if there is another node.
print:  # Print the sum.

	addi a7,zero,1  # Prepare to print an integer.
	ecall  # Print the number in a0.
	addi a7,zero,10  # Prepare to exit the program.
	ecall  # Exit.

# Follows the next pointers and adds every node value.
# Expected output: 19

# Worked example
# 5 -> 9 -> -2 -> 0 -> 7 gives running sums 5 -> 14 -> 12 -> 12 -> 19.
