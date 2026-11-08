.data  # Data and inputs.
    values: .word 54, 6, 57, 87, 57, 5, 435, 43, 3, 4  # Store the nonempty array of signed integers.
    values_end:  # Mark the end of the array.
.text  # Start of the program.
    la t0, values  # Load the first element address.
    la t1, values_end  # Load the end address.
    lw a0, 0(t0)  # Start with the first value as max.
loop:  # Check the rest of the array.
    addi t0, t0, 4  # Advance to the next four-byte element.
    beq t0, t1, print  # Stop before reading past the array.
    lw t2, 0(t0)  # Read the next integer.
    ble t2, a0, loop  # Keep the max if this value is <= it.
    mv a0, t2  # Replace the maximum in a0 with the larger integer.
    j loop  # Go back to check the next element.
print:  # Print the largest value.
    li a7, 1  # Prepare to print an integer.
    ecall  # Print the number in a0.
    li a7, 10  # Prepare to exit the program.
    ecall  # Exit.

# Scans the array for its largest signed integer using an end label.
# Expected output: 435

# Worked example
# Largest so far: 54 -> 57 -> 87 -> 435. Smaller values leave it unchanged.
