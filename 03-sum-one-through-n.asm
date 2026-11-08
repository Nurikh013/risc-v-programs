.data  # Data and inputs.
    n: .word 10  # Store the upper limit n.

.text  # Start of the program.
    lw x6, n  # Load n into x6, the countdown register.
    addi x10, x0, 0  # Start the sum in x10 (a0) at zero.

    blez x6, print  # If n <= 0, print zero.
loop:  # Countdown loop.
    add x10, x10, x6  # Add the current number to the running sum.
    addi x6, x6, -1  # Subtract one from the current number.
    bgt x6, x0, loop  # Repeat while the current number is positive.
print:  # Print the sum.

    addi x17, x0, 1  # Prepare to print an integer.
    ecall  # Print the number in a0.

    addi x17, x0, 10  # Prepare to exit the program.
    ecall  # Exit.

# Adds the integers from 1 through n.
# Expected output: 55

# Worked example
# 10 + 9 + 8 + ... + 1 -> 55
