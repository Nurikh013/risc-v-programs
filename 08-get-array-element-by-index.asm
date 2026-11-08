.data  # Data and inputs.
	index: .word 4  # Store the requested zero-based index.
	count: .word 6  # Store the number of elements.
	values: .word 1,2,4,5,6,7  # Store the array as four-byte integers.
.text  # Start of the program.
	ori x17,x0,1  # Prepare to print an integer.

	lw x6,index  # Load the requested index.
	lw x7,count  # Load the array length.
	bltz x6,invalid  # Reject a negative index.
	bge x6,x7,invalid  # Reject an index at or beyond the array length.
	la x8,values  # Load the address of the first element.

	slli x6,x6,2  # Byte offset = index x 4.
	add x8,x8,x6  # Add the byte offset to the starting address.

	lw x10,0(x8)  # Load the selected integer into x10 (a0).
	j print  # Skip the invalid-index handler.
invalid:  # Handle an out-of-range index.
	li a0,-1  # Use -1 to signal an invalid index.
print:  # Print the selected value or error value.
	ecall  # Print the number in a0.
	addi x17,x17,9  # Set service 10 (exit).
	ecall  # Exit.

# Reads the value at a zero-based index. Prints -1 for an invalid index.
# Expected output: 6

# Worked example
# [1, 2, 4, 5, 6, 7], index 4 -> byte offset 4 x 4 = 16 -> 6
