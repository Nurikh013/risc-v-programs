.data  # Data and inputs.
    values: .word 4, -2, 3, 4, 1  # Store the array to search.
    values_end:  # Mark the end of the array.
    target: .word 3  # Store the integer to find.
.text  # Start of the program.
    # Print the first zero-based index, or -1 if absent.
    la t0, values  # Load the starting address.
    la t1, values_end  # Load the end address.
    lw t2, target  # Load the target integer.
    li a0, 0  # Start the current zero-based index at zero in a0.
loop:  # Search loop.
    beq t0, t1, missing  # At the end, report no match.
    lw t3, 0(t0)  # Read the current integer.
    beq t3, t2, print  # If found, print the index in a0.
    addi t0, t0, 4  # Move forward one four-byte element.
    addi a0, a0, 1  # Increase the index to match the new address.
    j loop  # Return to check the next element.
missing:  # Handle reaching the end without a match.
    li a0, -1  # Use -1 to signal that the target was absent.
print:  # Print the index or missing value.
    li a7, 1  # Prepare to print an integer.
    ecall  # Print the number in a0.
    li a7, 10  # Prepare to exit the program.
    ecall  # Exit.

# Prints the first zero-based index of the target, or -1 if it is absent.
# Expected output: 2

# Worked example
# Target 3 -> check index 0 (4), 1 (-2), 2 (3) -> print 2.
