.data  # Data and inputs.
    first: .asciz "Cat"  # Store Cat with a final zero byte.
    second: .asciz "Snowball"  # Store Snowball with a final zero byte.
.text  # Start of the program.
    la a0, first  # Put the address of Cat in a0.
    jal ra, print_line  # Call the helper. Save return in ra.
    la a0, second  # Put the address of Snowball in a0.
    jal ra, print_line  # Calls the same helper for the second word.
    li a7, 10  # Prepare to exit the program.
    ecall  # Exit.

print_line:  # Helper entry. It expects a string address in a0.
    li a7, 4  # Prepare to print a string.
    ecall  # Print the string at a0.
    li a0, 10  # Put the newline character code in a0.
    li a7, 11  # Prepare to print a character.
    ecall  # Print a newline.
    ret  # Return to the address saved in ra.

# Calls a helper to print each word on its own line.
# Expected output: Cat, then Snowball on the next line

# Worked example
# Print Cat -> newline -> print Snowball -> newline.
