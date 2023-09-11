atoi:
    push    ebx            
    push    ecx             
    push    edx             
    push    esi             
    mov     esi, eax        
    mov     eax, 0          
    mov     ecx, 0         
 
.multiplyLoop:
    xor     ebx, ebx      
    mov     bl, [esi+ecx]   
    cmp     bl, 48          
    jl      .finished       
    cmp     bl, 57          
    jg      .finished       
 
    sub     bl, 48          
    add     eax, ebx        
    mov     ebx, 10         
    mul     ebx             
    inc     ecx             
    jmp     .multiplyLoop   
 
.finished:
    cmp     ecx, 0          
    je      .restore        
    mov     ebx, 10        
    div     ebx             
 
.restore:
    pop     esi             
    pop     edx             
    pop     ecx             
    pop     ebx             
    ret

read:
    push edx
    push ecx
    push ebx
    push eax

    mov edx, 255
    mov ebx, 0
    mov eax, 3

    int 80h

    mov eax,54          ; kernel function SYS_IOCTL
    mov ebx,0           ; EBX=0: STDIN
    mov ecx,0x540B      ; ECX=0x540B: TCFLSH
    xor edx, edx        ; EDX=0: TCIFLUSH
    int 80h            ; sys_call


    pop eax
    pop ebx
    pop ecx
    pop edx

    ret

addPrint:
    push eax
    mov eax, testmsg
    call sprint
    pop eax
    ;test
    mov al , [eax]
    movzx eax, al

    mov al, [ebx]
    movzx ebx, al

    add eax, ebx
    ;print equal sign
    push eax
    mov eax, 3Dh
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax

    
    ;print result
    call iprintLF
    ret

subPrint:
    sub eax, ebx
    ;print equal sign
    push eax
    mov eax, 3Dh
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax

    
    ;print result
    call iprintLF
    ret

mulPrint:
    mul ebx
    ;print equal sign
    push eax
    mov eax, 3Dh
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax

    
    ;print result
    call iprintLF
    ret

divPrint:
    push edx
    push ecx
    push ebx
    push eax
    mov edx, 0
    mov ecx, 0
    mov eax, ebx
    idiv eax
    mov eax, edx
    ;print equal sign
    push eax
    mov eax, 3Dh
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax

    
    ;print result
    call iprintLF
    ret



iprint:
    push eax
    push ecx
    push edx
    push esi
    mov ecx, 0

divideLoop:
    inc ecx
    mov edx, 0
    mov esi, 10
    idiv esi
    add edx, 48
    push edx
    cmp eax, 0
    jnz divideLoop

printLoop:
    dec ecx
    mov eax, esp
    call sprint
    pop eax
    cmp ecx, 0
    jnz printLoop

    pop esi
    pop edx
    pop ecx
    pop eax
    ret

iprintLF:
    call iprint

    push eax
    mov eax, 0Ah
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret

slen:
    push ebx
    mov ebx, eax

nextchar:
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextchar

finished:
    sub eax, ebx
    pop ebx
    ret

;------------------------
sprint:
    push edx
    push ecx
    push ebx
    push eax
    call slen

    mov edx, eax
    pop eax

    mov ecx, eax
    mov ebx, 1
    mov eax, 4
    int 80h

    pop ebx
    pop ecx
    pop edx
    ret
;------------------------

bprint:
    push edx
    push eax
    push ecx
    push ebx

    mov edx, 1
    mov ecx, eax
    mov ebx, 1
    mov eax, 4
    int 80h

    pop ebx
    pop ecx
    pop eax
    pop edx

    ret



sprintLF:
    call sprint

    push eax
    mov eax, 0Ah
    push eax
    mov eax, esp
    call sprint
    pop eax
    pop eax
    ret


quit:
    mov ebx, 0
    mov eax, 1
    int 80h
    ret