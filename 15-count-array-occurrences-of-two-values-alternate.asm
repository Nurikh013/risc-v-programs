.data  # Data and inputs.
   list: .word 4, 2, 3, 4, 4, 3, 1  # Store the array to search.
   n: .word 7  # Store the number of elements.
   x: .word 3  # Store the first target value.
   y: .word 4  # Store the second target value.

.text  # Start of the program.
    la s0, list  # Load the address of the first element.
    lw s1, n  # Load the array length.

    lw t2, x  # Load the first target.
    lw t3, y  # Load the second target.

    li t0, 0  # Start the match count in t0 at zero.
    li t1, 0  # Start the zero-based index in t1 at zero.

loop:  # Start of the loop that checks each element.
    bge t1, s1, print_result  # Stop when the index reaches the array length.
    lw t4, 0(s0)  # Read the element at the current address.
    beq t4, t2, inc_counter  # Count a match with x.
    beq t4, t3, inc_counter  # Count a match with y.
    j update_loop  # No match. Move on.

update_loop:  # Update the address and index together.
           addi s0, s0, 4  # Advance 4 bytes.
           addi t1, t1, 1  # Increase the index by one.
           j loop  # Return to the loop condition.

inc_counter:  # Handle a matching element.
          addi t0, t0, 1  # Add one to the match count.
          j update_loop  # Go to the next-element step.

print_result:  # Prepares the count for printing.
          mv a0, t0  # Copy the count from t0 to a0.
          li a7, 1  # Prepare to print an integer.
          ecall  # Print the number in a0.

          li a7, 10  # Prepare to exit the program.
          ecall  # Exit.

# Counts matches for either target using a separate loop index.
# Expected output: 5

# Worked example
# [4, 2, 3, 4, 4, 3, 1] -> matches at indices 0, 2, 3, 4, 5 -> 5

# A nonpositive count produces 0 matches.
