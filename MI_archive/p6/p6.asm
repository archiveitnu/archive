section .data
    scan_fmt db `%63[^\n]`, 0
    result db "Reversed String: %s", 10, 0

section .bss
    string resb 64

section .text
    global main
    extern printf
    extern scanf
main:
    push string
    push scan_fmt
    call scanf
    add esp, 8
    
    call REVERSE_STRING
    
    push string
    push result
    call printf
    add esp, 8
    
    xor eax, eax
    ret
    
REVERSE_STRING:
    lea esi, [string]
    lea edi, [string]
    
FIND_END:
    mov al, [edi]
    
    cmp al, 0
    je END_FOUND
    
    inc edi
    jmp FIND_END
    
END_FOUND:
    dec edi

REVERSE:
    cmp esi, edi
    jge REVERSE_DONE
    
    mov al, [esi]
    mov bl, [edi]
    
    mov [esi], bl
    mov [edi], al
    
    inc esi
    dec edi
    
    jmp REVERSE
    
REVERSE_DONE:
    ret