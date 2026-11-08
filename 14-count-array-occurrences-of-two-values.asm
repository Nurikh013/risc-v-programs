.data  # Data and inputs.
    n:.word 10  # Store the number of elements.
    v:.word 3,2,4,5,4,3,4,1,7,8  # Store the array to search.
    x:.word 3  # Store the first target value.
    y:.word 4  # Store the second target value.
.text  # Start of the program.
	lw t0,n  # Load the remaining element count.
	la t1,v  # Load the address of the first element.
	lw s0,x  # Load the first target.
	lw s1,y  # Load the second target.
	li a0,0  # Start the match count at zero.
	blez t0,print  # Print zero immediately for an empty array.
loop:  # Matching loop.
	lw t2,0(t1)  # Read the current element.
	bne t2,s0,second  # If the value differs from x, check y.
	addi a0,a0,1  # Count the match with the first target.
	j end  # Skip y to avoid counting twice.
second:  # Check the second target.
	bne t2,s1,end  # Skip if it also differs from y.
	addi a0,a0,1  # Count the match with the second target.

end:  # Move on after either outcome.
	addi t0,t0,-1  # Decrease the remaining count.
	addi t1,t1,4  # Advance the array address by four bytes.
	bgt t0,x0,loop  # Repeat while elements remain.
print:  # Print the match count.
	li a7,1  # Prepare to print an integer.
	ecall  # Print the number in a0.
	li a7,10  # Prepare to exit the program.
	ecall  # Exit.

# Counts elements equal to either of the two target values.
# Expected output: 5

# Worked example
# Targets 3 and 4 -> matching values [3, 4, 4, 3, 4] -> 5 matches.
