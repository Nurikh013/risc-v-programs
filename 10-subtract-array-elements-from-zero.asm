.data  # Data and inputs.
    count: .word 5  # Store the number of elements.
    values: .word 1,2,3,4,5  # Store the integers to subtract.

.text  # Start of the program.
	la x5,values  # Load the first element address.
	lw x6,count  # Load the number of elements remaining.
	ori x10,x0,0  # Start the result in x10 (a0) at zero.
blez x6,print  # Skip the loop when there are no elements.
loop:  # Subtraction loop.
	lw x7,0(x5)  # Read the current four-byte integer.
	addi x5,x5,4  # Advance to the next integer address.
	sub x10,x10,x7  # Subtract the current value.
	addi x6,x6,-1  # Decrease the remaining element count.
	bgt x6,x0,loop  # Repeat while elements remain.
print:  # Print the result.

	ori x17,x0,1  # Prepare to print an integer.
	ecall  # Print the number in a0.

	ori x17,x0,10  # Prepare to exit the program.
	ecall  # Exit.

# Starts at zero and subtracts each array element in order.
# Expected output: -15

# Worked example
# [1, 2, 3, 4, 5] -> 0 -> -1 -> -3 -> -6 -> -10 -> -15
