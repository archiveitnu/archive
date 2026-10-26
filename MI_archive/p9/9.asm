extern printf
extern scanf

global main

section .data
    input_fmt db "%d", 0
    output_msg db "Fibonacci Series: ", 10, 0
    num_fmt db "%d ", 0
    newline db 10, 0

section .bss
    n resd 1

section .text

main:

    push n
    push input_fmt
    call scanf
    add esp, 8

    push output_msg
    call printf
    add esp, 4

    mov ecx, [n]
    call FIBONACCI

    push newline
    call printf
    add esp, 4

    xor eax, eax
    ret

FIBONACCI:

    mov eax, 0          
    mov ebx, 1         

    cmp ecx, 0
    jle DONE

GENERATE:

    push eax
    push ebx
    push ecx

    push eax
    push num_fmt
    call printf
    add esp, 8

    pop ecx
    pop ebx
    pop eax

    mov edx, eax
    add edx, ebx

    mov eax, ebx
    mov ebx, edx

    dec ecx
    cmp ecx, 0
    jg GENERATE

DONE:
    ret