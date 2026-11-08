.data  # Data and inputs.
	count: .word 3  # Store the number of elements.
	values: .word 3,4,13  # Store the integers to add.
.text  # Start of the program.
	la x8,values  # Load the first element address.
	lw x6,count  # Load the number of elements remaining.
	li a0,0  # Start the sum at zero in a0 (x10).
	ori x17,x0,1  # Prepare to print an integer.
	blez x6,print  # Skip the loop when there are no elements.
loop:  # Array loop.
	lw x7,0(x8)  # Read the integer at the current address.
	add x10,x10,x7  # Add that integer to the running sum.
	addi x8,x8,4  # Step to the next integer (+4 bytes).
	addi x6,x6,-1  # Decrease the remaining element count.
	bgt x6,x0,loop  # Repeat while there are elements left.
print:  # Print the sum.
	ecall  # Print the number in a0.
	addi x17,x17,9  # Set service 10 (exit).
	ecall  # Exit.

# Adds all the integers in the array.
# Expected output: 20

# Worked example
# [3, 4, 13] -> running sums 0 -> 3 -> 7 -> 20
