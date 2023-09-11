%include 'functions.asm'

section .data
msg1 db 'Please enter operator: ', 0h
msg2 db 'Please enter first number: ', 0h
msg3 db 'Please enter second number: ', 0h
rem db ' remainder '
testmsg db 'test', 0Ah

section .bss
input1: resb 1
input2: resb 1
input3: resb 1



section .text
global _start 

_start:
    ;print first line
    mov eax, msg1
    call sprint

    ;setup and read input
    mov ecx, input1
    call read
    push input1

    ;print second line
    mov eax, msg2
    call sprint

    ;setup and read input
    mov ecx, input2
    call read
    push input2

    ;print third line
    mov eax, msg3
    call sprint

    ;setup and read input
    mov ecx, input3
    call read
    push input3


    pop ebx
    pop eax
    pop ecx

    call sprint
    
    
    ; mov eax, msg2
    ; call sprint
    ; mov ecx, input2
    ; call sread
    ; push input2
    ; mov eax, msg3
    ; call sprint
    ; mov ecx, input3
    ; call sread
    ; push input3

    ; pop ecx
    ; pop ebx
    ; pop eax

    ; mov eax, 2Bh
    ; mov ebx, 2
    ; mov ecx, 3
    ; push eax
    ; mov eax, testmsg
    ; call sprint
    ; pop eax 
    ; call sprint

    ; push eax
    ; mov eax, 2Bh
    ; call sprint
    ; pop eax

    ; push eax
    ; mov eax, ecx
    ; call sprint
    ; pop eax
    ; call addPrint

    cmp eax, 43
    je addPrint

    cmp eax, 2Dh
    je subPrint

    cmp eax, 42
    je mulPrint

    cmp eax, 47
    je divPrint


    ; mov eax, 90
    ; mov ebx, 9
    ; call addPrint

    call quit


