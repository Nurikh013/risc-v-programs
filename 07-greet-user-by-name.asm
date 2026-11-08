.data  # Data and inputs.
    prompt: .asciz "What's your name? "  # Prompt text, ending in a zero byte.
    greeting: .asciz "Hello, "  # Greeting text, ending in a zero byte.
    name: .space 30  # Reserve 30 bytes for the name.
.text  # Start of the program.
    la a0, prompt  # Put the prompt address in a0.
    li a7, 4  # Prepare to print a string.
    ecall  # Print the string at a0.
    la a0, name  # Put the input buffer address in a0.
    li a1, 30  # Set the input buffer size to 30 bytes in a1.
    li a7, 8  # Prepare to read a string.
    ecall  # Read a name into the buffer.
    la a0, greeting  # Put the greeting prefix address in a0.
    li a7, 4  # Prepare to print a string.
    ecall  # Print the string at a0.
    la a0, name  # Put the address of the name just read in a0.
    li a7, 4  # Prepare to print a string.
    ecall  # Print the string at a0.
    li a7, 10  # Prepare to exit the program.
    ecall  # Exit.

# Prompts for a name, reads it, and prints a greeting.
# Example: Enter Ada to see Hello, Ada

# Worked example
# Console: What's your name? Ada
# Console: Hello, Ada
