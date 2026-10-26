section .data
    input db 10 dup(0)
    infmt db "%9s", 0
    fmt db "Set bits = %d, Parity = %s", 10, 0
    even db "Even", 0
    odd db "Odd", 0
    invalid_msg db "Invalid input. Enter exactly 8 binary bits.", 10, 0

section .text
    global main
    extern printf
    extern scanf

main:

    push input
    push infmt
    call scanf
    add esp, 8

    mov esi, input
    xor ecx, ecx

check_input:

    mov al, byte [esi]

    cmp al, '0'
    je valid_bit

    cmp al, '1'
    je valid_bit

    jmp invalid_input

valid_bit:

    inc esi
    inc ecx

    cmp ecx, 8
    je check_end

    jmp check_input

check_end:

    cmp byte [esi], 0
    jne invalid_input

    mov esi, input
    xor ebx, ebx
    mov ecx, 8

convert:

    shl ebx, 1

    movzx eax, byte [esi]
    sub eax, '0'

    add ebx, eax

    inc esi
    loop convert

    mov eax, ebx
    xor edx, edx
    xor edi, edi
    mov ecx, 8

count_bits:

    mov ebx, eax
    and ebx, 1

    add edx, ebx
    xor edi, ebx

    shr eax, 1

    loop count_bits

    cmp edi, 0
    je even_parity

    push odd
    push edx
    push fmt
    call printf
    add esp, 12

    jmp done

even_parity:

    push even
    push edx
    push fmt
    call printf
    add esp, 12

    jmp done

invalid_input:

    push invalid_msg
    call printf
    add esp, 4

done:
    ret