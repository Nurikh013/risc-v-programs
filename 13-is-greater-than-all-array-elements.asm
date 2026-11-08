.data  # Data and inputs.
	n:.word 10  # Store the number of elements.
	v:.word 2,3,4,5,6,3,5,8,10,9  # Store the integers to compare against x.
	x:.word 11  # Store the comparison value x.
.text  # Start of the program.
	lw t0,n  # Load the remaining count.
	la t1,v  # Load the address of the first array element.
	lw s0,x  # Load x.
	li a0,1  # Assume success (1) to start.
	blez t0,print  # Print 1 immediately for an empty array.
loop:  # Comparison loop.
	lw t2,0(t1)  # Read the current array element.
	blt t2,s0,end  # Continue if element < x.
	li a0,0  # Set the result to 0 if element >= x.
	j print  # Stop scanning because the test has already failed.
end:  # Continue after a successful check.
	addi t0,t0,-1  # Decrease the remaining count.
	addi t1,t1,4  # Move forward one four-byte element.
	bgt t0,zero,loop  # Repeat while more elements remain.
print:  # Print the result flag.
	li a7,1  # Prepare to print an integer.
	ecall  # Print the number in a0.
	li a7,10  # Prepare to exit the program.
	ecall  # Exit.

# Prints 1 if x is strictly greater than every array element, or 0 otherwise.
# Expected output: 1

# Worked example
# x = 11 -> even the largest element (10) is smaller -> print 1.
