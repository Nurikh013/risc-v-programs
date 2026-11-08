.data  # Data and inputs.
	n:.word 7  # Store the array length.
	v:.word 4,-2,3,4,4,3,1  # Store the integers to add from.
	x:.word 2  # Store the starting zero-based index.
	y:.word 3  # Store the ending zero-based index.
.text  # Start of the program.
	lw s0,x  # Load the starting index.
	lw s1,y  # Load the ending index.
	la s2,v  # Load the first element address.
	li a0,0  # Start the running sum at zero.
	lw t0,n  # Load the array length for bounds checking.
	bltz s0,print  # Reject a negative starting index.
	blt s1,s0,print  # Reject an ending index below the starting index.
	bge s1,t0,print  # Reject an ending index outside the array.
	slli t0,s0,2  # Byte offset = start index x 4.
	add s2,s2,t0  # Move to the starting index.
loop:  # Start of the loop over the selected range.
	lw t0,0(s2)  # Read the integer at the current address.
	add a0,a0,t0  # Add that integer to the sum.
	addi s0,s0,1  # Advance the current index by one.
	addi s2,s2,4  # Advance the current address by four bytes.
	ble s0,s1,loop  # Repeat while index <= end index.
print:  # Print the range sum.

	li a7,1  # Prepare to print an integer.
	ecall  # Print the number in a0.
	li a7,10  # Prepare to exit the program.
	ecall  # Exit.

# Adds values from the starting index through the ending index, inclusive. Prints 0 for an invalid range.
# Expected output: 7

# Worked example
# Indices 2 through 3 -> values 3 and 4 -> 3 + 4 = 7.
