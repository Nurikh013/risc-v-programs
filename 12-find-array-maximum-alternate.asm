.data  # Data and inputs.
    count: .word 9  # Number of array elements.
    values: .word 12, 9, -23, 0, 39, 3, 4, 1, 9  # Store the signed integers to compare.

.text  # Start of the program.
    la t0, values  # Load the first element address.
    lw t1, count  # Load the element count.
    blez t1, invalid  # Reject an empty or negative element count before reading.
    lw a0, 0(t0)  # Use the first element as the initial maximum.
    addi t1, t1, -1  # Subtract one from the count.

    blez t1, print  # Skip if no elements remain.
loop:  # Start of the loop over the remaining elements.
    addi t1, t1, -1  # Count this element as processed.
    addi t0, t0, 4  # Advance 4 bytes to that element.
    lw t2, 0(t0)  # Read the element.
    ble t2, a0, end  # Keep the max if this value is <= it.
    addi a0, t2, 0  # Copy the new maximum into a0 by adding zero.

end:  # Both comparison outcomes continue here.
    bgt t1, zero, loop  # Repeat while more elements remain.
    j print  # Skip the invalid-count handler.
invalid:
    li a0, 0  # No maximum exists; use 0 as the documented empty-input result.
print:  # Print the largest value.

    addi a7, zero, 1  # Prepare to print an integer.
    ecall  # Print the number in a0.

    addi a7, zero, 10  # Prepare to exit the program.
    ecall  # Exit.

# Scans the array for its largest signed integer using an element count.
# Expected output: 39

# Worked example
# Largest so far: 12 -> 39. After checking all 9 values, print 39.

# Prints 0 when count <= 0. Positive counts must match the array length.
