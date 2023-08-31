section .bss
    ;variables

section .data
    ;constatnts
    hello: db "Hello, World!", 10 ;define string in memory
    helloLen: equ $-hello ;length of string

section .text
    global _start

    _start:
        mov rax, 1 ;system call for write
        mov rdi, 1 ;file descriptor 1 is stdout
        mov rsi, hello ;address of string to output
        mov rdx, helloLen ;message len
        syscall

        mov rax, 60 ;system call for exit
        mov rdi, 0 ;exit code 0
        syscall


