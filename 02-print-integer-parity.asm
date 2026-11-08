.data  # Data and inputs.
    number: .word 10  # Store the integer to test.
    even: .asciz "pari"  # Store the word for even, with a final zero byte.
    odd: .asciz "dispari"  # Store the word for odd, with a final zero byte.
.text  # Start of the program.
    lw t0, number  # Load the integer from memory.
    andi t0, t0, 1  # Keep the low bit (0 even, 1 odd).
    la a0, even  # Select the even message by default.
    beqz t0, print  # If the lowest bit is zero, jump to print.
    la a0, odd  # Otherwise select the odd message.
print:  # The selected string address is now in a0.
    li a7, 4  # Prepare to print a string.
    ecall  # Print the string at a0.
    li a7, 10  # Prepare to exit the program.
    ecall  # Exit.

# Checks the lowest bit to tell whether an integer is even or odd.
# Expected output: pari (even)

# Worked example
# 10 AND 1 -> 0 -> even -> print pari
