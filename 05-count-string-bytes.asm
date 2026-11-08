.data  # Data and inputs.
	message: .asciz "I will smash this Computer Architecture mid-term "  # Text with a trailing space and zero byte.
.text  # Start of the program.
	ori x17,x0,1  # Prepare to print an integer.
	la x12,message  # Load the address of the first byte.
	ori x10,x0,0  # Start the byte count in x10 (a0) at zero.
loop:  # Start of the scan for the terminating zero.
	lb x11,0(x12)  # Read the byte at the address in x12.
	beq x11,x0,print  # Stop if that byte is zero.
	addi x10,x10,1  # Count the nonzero byte just read.
	addi x12,x12,1  # Advance the address by one byte.
	beq x0,x0,loop  # Jump back because x0 always equals itself.
print:  # Print the byte count.
	ecall  # Print the number in a0.
	li a7,10  # Prepare to exit the program.
	ecall  # Exit.

# Counts the bytes before the terminating zero, including the trailing space.
# Expected output: 49

# Worked example
# "Hi " -> H, i, space, zero byte -> 3 bytes counted; the file's longer string gives 49.
