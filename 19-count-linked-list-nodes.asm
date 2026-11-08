.data  # Data and inputs.
    list:  .word node1  # Pointer to the first node.
    node1: .word 5, node2  # Value 5, next is node2.
    node2: .word 9, node3  # Value 9, next is node3.
    node3: .word -2, node4  # Value -2, next is node4.
    node4: .word 0, node5  # Store 0 as a value and a pointer to node5.
    node5: .word 7, node6  # Value 7, next is node6.
    node6:.word 9,node7  # Value 9, next is node7.
    node7:.word 1,0  # Value 1, end of list.
.text  # Start of the program.
	lw s1,list  # Load the list head.
	addi a0,zero,0  # Start the node count at zero.
beqz s1,print  # If the list is empty, print 0.
loop:  # Node-counting loop.
	addi a0,a0,1  # Count the current node.
	lw s1,4(s1)  # Load the next pointer at offset 4.
	bne s1,zero,loop  # Repeat if the next pointer is nonzero.
print:  # Print the count.
	li a7,1  # Prepare to print an integer.
	ecall  # Print the number in a0.
	li a7,10  # Prepare to exit the program.
	ecall  # Exit.

# Counts the nodes in a linked list. A node with a value of zero still counts.
# Expected output: 7

# Worked example
# 5 -> 9 -> -2 -> 0 -> 7 -> 9 -> 1 -> null. The node holding 0 counts too -> 7.
