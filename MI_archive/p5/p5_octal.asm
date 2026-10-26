section .data
    scan_fmt db "%31s", 0
    print_fmt db "%c", 0
    new_line db 10,0
    err_msg db "Error: Not a valid octal number"
    
section .bss
    octal resb 32
    
section .text
    global main
    extern printf
    extern scanf

main:
    push octal 
    push scan_fmt
    call scanf
    add esp, 8
    
    lea esi, [octal]
    
NEXT_DIGIT:
    mov al, [esi]
    
    cmp al, 0
    je DONE
    
    cmp al, '0'
    jb INVALID
    
    cmp al, '7'
    ja INVALID
    
    sub al, '0'
    
    mov bl, al
    
    mov al, bl
    and al, 04H
    jz FIRST_ZERO
    
    mov edx, '1'
    jmp PRINT_FIRST
    
FIRST_ZERO:
    mov edx, '0'
    
PRINT_FIRST:
    push edx
    push print_fmt
    call printf
    add esp, 8
    
    mov al, bl
    and al, 02H
    jz SECOND_ZERO
    
    mov edx, '1'
    jmp PRINT_SECOND
    
SECOND_ZERO:
    mov edx, '0'
    
PRINT_SECOND:
    push edx
    push print_fmt
    call printf
    add esp, 8
    
    mov al, bl
    and al, 01H
    jz THIRD_ZERO
    
    mov edx, '1'
    jmp PRINT_THIRD
    
THIRD_ZERO:
    mov edx, '0'
    
PRINT_THIRD:
    push edx
    push print_fmt
    call printf
    add esp, 8
    
    inc esi
    jmp NEXT_DIGIT
    
INVALID:
    push err_msg
    call printf
    add esp, 4
    mov eax, 1
    ret
    
DONE:
    push new_line
    call printf
    add esp, 4
    
    xor eax, eax
    ret