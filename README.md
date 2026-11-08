# RISC-V Programs

23 small, commented assembly exercises covering integer operations, strings,
arrays, linked lists, and binary search trees. Each file is an independent
program with its own data, worked example, and expected output.

## Run an example

1. Install Java 8 or newer.
2. Download `rars1_6.jar` from the [official RARS 1.6 release](https://github.com/TheThirdOne/rars/releases/tag/v1.6).
3. Open RARS, open **one** `.asm` file, assemble it, then run it.
   Use the default **32-bit** mode with pseudo-instructions enabled.
   Do not assemble the entire directory together: labels repeat between examples.

From a terminal in this directory:

```sh
java -jar /path/to/rars1_6.jar nc 04-factorial.asm
```

Example 07 asks for a name in the console. The others use the values in `.data`;
edit those values and reassemble to try different inputs.

These examples target RARS's simulated environment calls (`a7`: 1 = print
integer, 4 = print string, 8 = read string, 10 = exit, 11 = print character).
They are not Linux executables and cannot run directly on a RISC-V board.
Factorial uses the multiplication extension (`mul`); use RV32IM support.

## Examples

| File | Topic | Default output |
| --- | --- | --- |
| [01](01-minimum-of-two-integers.asm) | Smaller of two signed integers | `111222333` |
| [02](02-print-integer-parity.asm) | Parity (`pari` = even, `dispari` = odd) | `pari` |
| [03](03-sum-one-through-n.asm) | Sum 1 through n | `55` |
| [04](04-factorial.asm) | Factorial | `5040` |
| [05](05-count-string-bytes.asm) | String byte length | `49` |
| [06](06-print-two-words.asm) | Helper procedure and newlines | `Cat`, then `Snowball` |
| [07](07-greet-user-by-name.asm) | Read a name and print a greeting | `What's your name? Hello, Ada` with input `Ada` |
| [08](08-get-array-element-by-index.asm) | Array indexing | `6` |
| [09](09-sum-array-elements.asm) | Array sum | `20` |
| [10](10-subtract-array-elements-from-zero.asm) | Array subtraction | `-15` |
| [11](11-find-array-maximum.asm) | Maximum using an end label | `435` |
| [12](12-find-array-maximum-alternate.asm) | Maximum using a count | `39` |
| [13](13-is-greater-than-all-array-elements.asm) | Strict comparison against every element | `1` |
| [14](14-count-array-occurrences-of-two-values.asm) | Count either target | `5` |
| [15](15-count-array-occurrences-of-two-values-alternate.asm) | Count either target using an index | `5` |
| [16](16-find-number-in-array.asm) | First matching index | `2` |
| [17](17-sum-array-index-range.asm) | Inclusive range sum | `7` |
| [18](18-count-linked-list-nodes-four-node-example.asm) | Four-node linked list | `4` |
| [19](19-count-linked-list-nodes.asm) | Linked-list length | `7` |
| [20](20-sum-linked-list-values.asm) | Linked-list sum | `19` |
| [21](21-sum-positive-linked-list-values.asm) | Sum positive values | `15` |
| [22](22-sum-odd-indexed-linked-list-values.asm) | Sum positions 1, 3, 5, ... | `5` |
| [23](23-search-binary-search-tree.asm) | Binary search tree lookup | `1` |

Most integer examples print no final newline. RARS may display its own
termination message separately from the program output.

## Input rules and limitations

- Array indices are zero-based. Positive array counts must not exceed the
  actual number of allocated elements. Example 11 requires a nonempty array.
- Example 12 returns 0 for a nonpositive count (an empty array has no maximum).
- Example 04 accepts 0 through 12; other inputs print -1.
- Example 08 prints -1 for an invalid index; example 16 prints -1 for no match.
- Example 17 prints 0 for an invalid range. Both endpoints are inclusive.
- Nonpositive counts in the counting/summing examples skip their loops.
  Example 13 returns 1 for an empty array.
- Arithmetic uses 32-bit registers; sums and differences can overflow.
- String length counts bytes, not Unicode characters. Name input reserves 30
  bytes, including the terminating zero, and may retain the entered newline.
- Linked-list nodes are `(value, next)` words. Tree nodes are
  `(value, left, right)` words. Zero pointers mark the end. Lists and trees
  must contain valid aligned pointers and no cycles; the tree must be ordered.
- These are standalone teaching programs, not a general-purpose ABI library.

## Check the programs

Install Python 3.8+ and run:

```sh
python tests/check.py /path/to/rars1_6.jar
```

If Java is not on PATH, add `--java /path/to/java`. The checker runs every
default example and boundary cases, comparing actual console output with
expected results. It supplies `Ada` to the interactive example and uses
instruction and time limits to detect loops. Test variants use temporary
files and leave the examples unchanged.

## Reuse

No license has been selected. Contact the repository owner before reusing or
redistributing the code beyond permissions provided by applicable law.
