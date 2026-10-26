section .text
    global main
    extern printf

section .data
    arr db 12, 5, 25, 8, 3, 19, 7, 15
    fmt db "Maximum = %d", 10, "Minimum = %d", 10, 0

main:
    mov rsi, arr

    mov al, [rsi]
    mov bl, al
    mov bh, al

    mov ecx, 7
    inc rsi

next:
    mov al, [rsi]

    cmp al, bl
    jbe check_min
    mov bl, al

check_min:
    cmp al, bh
    jae continue
    mov bh, al

continue:
    inc rsi
    loop next

    movzx esi, bl
    movzx edx, bh

    mov rdi, fmt
    xor eax, eax
    call printf

    mov eax, 0
    ret