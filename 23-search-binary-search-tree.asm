.data  # Data and inputs.
tree:	.word n01  # Store the address of the root node.
n01:	.word 7, n02, n03  # Root 7, left n02, right n03.
n02:	.word 4, n04, n05  # Node 4, left n04, right n05.
n03:	.word 11, n06, n07  # Node 11, left n06, right n07.
n04:	.word 1, 0, 0  # Leaf 1, no children.
n05:	.word 6, 0, 0  # Leaf 6, no children.
n06:	.word 8, 0, 0  # Leaf 8, no children.
n07:	.word 26, 0, 0  # Leaf 26, no children.
N:	.word 6  # Store the target integer to find.

.text  # Start of the program.
    lw a0, tree  # Pass the root pointer in a0.
    lw a1, N  # Pass the target in a1.
    jal ra, search  # Calls search, saving the return address in ra.
    li a7, 1  # Prepare to print an integer.
    ecall  # Print the number in a0.
    li a7, 10  # Prepare to exit the program.
    ecall  # Exit.

# Return 1 if the target is present, or 0 otherwise.
search:  # Search: a0 = node, a1 = target.
    beqz a0, missing  # A null pointer means no match.
    lw t0, 0(a0)  # Read the node value at offset 0.
    beq t0, a1, found  # If the value matches, go to found.
    blt t0, a1, right  # If target > node value, go right.
    lw a0, 4(a0)  # Load the left child at offset 4.
    j search  # Continue searching from the left child.
right:  # Select the right subtree.
    lw a0, 8(a0)  # Load the right child pointer from byte offset 8.
    j search  # Continue searching from the right child.
found:  # Handle a matching node.
    li a0, 1  # Set the return value to 1.
    ret  # Return to the instruction after the original call.
missing:  # Handle a null child without finding the target.
    li a0, 0  # Set the return value to 0.
    ret  # Return to the instruction after the original call.

# Compares the target with each visited node to choose the next branch. Prints 1 if found and 0 if absent.
# Expected output: 1

# Worked example
# Find 6: start at 7 -> go left to 4 -> go right to 6 -> found -> print 1.
