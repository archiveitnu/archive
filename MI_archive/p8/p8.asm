section .data
    mainstr db 100 dup(0)
    substr db 50 dup(0)

    infmt1 db " %99[^\n]", 0
    infmt2 db " %49[^\n]", 0

    found db "Substring found", 10, 0
    notfound db "Substring not found", 10, 0

section .text
    global main
    extern printf
    extern scanf

main:

    push mainstr
    push infmt1
    call scanf
    add esp, 8

    push substr
    push infmt2
    call scanf
    add esp, 8

    push substr
    push mainstr
    call find_substring
    add esp, 8

    cmp eax, 1
    je found_msg

    push notfound
    call printf
    add esp, 4
    jmp done

found_msg:
    push found
    call printf
    add esp, 4

done:
    ret


find_substring:

    push ebp
    mov ebp, esp

    mov esi, [ebp+8]
    mov edi, [ebp+12]

next_position:

    movzx eax, byte [esi]
    cmp eax, 0
    je not_found

    mov ebx, esi
    mov edx, edi

compare:

    movzx eax, byte [ebx]
    movzx ecx, byte [edx]

    cmp ecx, 0
    je substring_found

    cmp eax, 0
    je move_next

    cmp eax, ecx
    jne move_next

    inc ebx
    inc edx

    jmp compare

move_next:
    inc esi
    jmp next_position

substring_found:
    mov eax, 1
    pop ebp
    ret

not_found:
    xor eax, eax
    pop ebp
    ret