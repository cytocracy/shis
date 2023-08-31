; Allow the linker to find the _start symbol. The linker will begin program execution
; there.
global _start

; Start the .rodata section of the executable, which stores constants (read only data)
; It doesn't matter which order your sections are in, I just like putting .data first
section .rodata
    ; Declare some bytes at a symbol called hello_world. NASM's db pseudo-instruction
    ; allows either a single byte value, a constant string, or a combination of the two
    ; as seen here. 0xA = new line, and 0x0 = string-terminating null
    hello_world: db "Hello world!", 0xA, 0x0

; Start the .text section, which stores program code
section .text
_start:
    mov eax, 0x04           ; store the number 4 in the eax register (0x04 = write())
    mov ebx, 0x1            ; file descriptor (1 = standard output, 2 = standard error)
    mov ecx, hello_world    ; pointer to the string we're printing
    mov edx, 14             ; length of the string
    int 0x80                ; send the interrupt signal 0x80 which the OS interprets as
                            ;   a syscall

    mov eax, 0x01           ; 0x01 = exit()
    mov ebx, 0              ; 0 = no errors
    int 0x80