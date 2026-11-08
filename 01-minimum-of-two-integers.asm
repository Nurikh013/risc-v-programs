.data  # Data and inputs.
    first: .word 111222333  # Store the first integer.
    second: .word 222333444  # Store the second integer.
.text  # Start of the program.
    lw a0, first  # Load the first number into a0.
    lw t0, second  # Load the second integer into t0 for comparison.
    ble a0, t0, print  # If first <= second, print first.
    mv a0, t0  # Otherwise copy the second value into a0.
print:  # The smaller value is now in a0.
    li a7, 1  # Prepare to print an integer.
    ecall  # Print the number in a0.
    li a7, 10  # Prepare to exit the program.
    ecall  # Exit.

# Prints the smaller of two signed integers.
# Expected output: 111222333

# Worked example
# 111222333 vs 222333444 -> keep 111222333 -> print 111222333
