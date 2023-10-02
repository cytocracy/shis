%include 'functions.asm'

section .data
msg1 db 'Please enter operator: ', 0h
msg2 db 'Please enter first number: ', 0h
msg3 db 'Please enter second number: ', 0h
rem db ' remainder ', 0h
testmsg db 'test', 0Ah

section .bss
input1: resb 255
input2: resb 255
input3: resb 255



section .text
global _start 

_start:
    ;print first line
    mov eax, msg1
    call sprint

    ;setup and read input
    mov ecx, input1
    call read
    mov eax , input1
    push eax

    ;print second line
    mov eax, msg2
    call sprint

    ;setup and read input
    mov ecx, input2
    call read
    mov eax , input2
    call atoi
    push eax
    
    ;print third line
    mov eax, msg3
    call sprint

    ;setup and read input
    mov ecx, input3
    call read
    mov eax, input3
    call atoi
    push eax

    pop ebx
    pop eax
    pop ecx
    
    cmp byte [ecx], 43
    je addnum

    cmp byte [ecx], 45
    je subnum

    cmp byte [ecx], 42
    je mulnum

    cmp byte [ecx], 47
    je divnum

    call quit

addnum:
    add eax, ebx
    call iprintLF
    call quit

subnum:
    sub eax, ebx
    call iprintLF
    call quit

mulnum:
    mul ebx
    call iprintLF
    call quit

divnum:
    push eax
    push ebx
    push edx
    div     ebx  
    call    iprint
    mov     eax, rem
    call    sprint
    mov     eax, edx
    call    iprintLF

    pop edx
    pop ebx
    pop eax

    call quit





