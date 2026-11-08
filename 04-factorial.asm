.data  # Data and inputs.
    n: .word 7  # Store the number whose factorial we want.
.text  # Start of the program.
    lw t0, n  # Load n.
    # 32-bit factorial range: 0 to 12.
    bltz t0, invalid  # Reject negative inputs.
    li t1, 12  # Set the 32-bit factorial limit to 12.
    bgt t0, t1, invalid  # Reject inputs above 12.
    li a0, 1  # Start at 1, the value of 0! and 1!.
    li t1, 1  # Set the stopping value to 1.
loop:  # Multiplication loop.
    ble t0, t1, print  # Stop when the remaining factor is 1 or less.
    mul a0, a0, t0  # Multiply by the current factor.
    addi t0, t0, -1  # Move to the next smaller factor.
    j loop  # Go back to test and multiply the next factor.
invalid:  # Handle inputs outside the supported range.
    li a0, -1  # Use -1 to signal an invalid input.
print:  # Print the result or error value.
    li a7, 1  # Prepare to print an integer.
    ecall  # Print the number in a0.
    li a7, 10  # Prepare to exit the program.
    ecall  # Exit.

# Multiplies the integers from 1 through n. Prints -1 outside the range 0 through 12.
# Expected output: 5040

# Worked example
# 7 x 6 x 5 x 4 x 3 x 2 -> 5040
