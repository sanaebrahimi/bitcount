CS456/556 Assignment #4

Convert the bitcount.c file to X86_64 assembly code.  To do this I recommend
copying the bitcount.c file as bitcount.s and begin converting the code line
by line.

- It is not recommended that you use the syscall registers: rax, rdi, rsi, rdx,
  r10, r8 or r9 (or r11) for your main program except for system calls, use rbx
  or r12-r15.  Preferably use memory for variable storage.

- The "command line parameters" to your assembly program are placed on the
  stack for you by the kernel.  They are located immediately before where the
  stack register (rsp) points to.  The first parameter is "argc", the value
  of which would be at [rsp].  argv is then "above" that location, each
  pointer is 8 bytes, thus argv[0] is at [rsp+8], argv[1] at [rsp+16], etc.
  If the value at [rsp+n*8] == 0, then you are at the end of the arguments
  list.

  To access the first character of argv[1], placing it in r15 would then
  require:

  mov r14, [rsp+16]	; loads address of argv[1] into r14. Remember that
			; argv[1] is a pointer (i.e. an address) to the
			; string, it must still be de-referenced.
  mov r15, BYTE [r14]	; Move the byte at the address in r14 into r15.

  For example code that accesses argc/argv, refer to the in-class code at:
  https://cs.indstate.edu/~sbaker/cs456/code.php?view=./code/02-08-The_Stack/argv.s
