section .data
    scan_fmt db `%63[^\n]`, 0
    result db "Converted String: %s", 10, 0
    
section .bss
    string resb 64

section .text
    extern printf
    extern scanf
    global main
main:
    push string
    push scan_fmt 
    call scanf
    add esp, 8
    
    lea esi, [string]
    
NEXT: 
    mov al, [esi]
    
    cmp al, 0
    je DISPLAY
    
    cmp al, 'a'
    jb CHECK_UPPER
    
    sub al, 20H
    mov [esi], al
    jmp NEXT_CHAR
    
CHECK_UPPER:
    cmp al, 'A'
    jb NEXT_CHAR
    
    cmp al, 'Z'
    ja NEXT_CHAR
    
    add al, 20H
    mov [esi], al
    
NEXT_CHAR:
    inc esi
    jmp NEXT
    
DISPLAY:
    push string
    push result
    call printf
    add esp, 8
    
    xor eax, eax
    ret