extern printf
extern scanf

global main

section .data
    fmt_in     db "%d", 0
    msg_even   db "The number is EVEN.", 10, 0
    msg_odd    db "The number is ODD.", 10, 0
    msg_prime  db "The number is PRIME.", 10, 0
    msg_not    db "The number is NOT PRIME.", 10, 0
    msg_invalid db "Invalid input! Enter 1 to 1000.", 10, 0

section .bss
    num resd 1

section .text

main:
    push ebp
    mov ebp, esp

    push num
    push fmt_in
    call scanf
    add esp, 8

    cmp eax, 1
    jne InvalidInput

    mov eax, [num]
    cmp eax, 1
    jl InvalidInput
    cmp eax, 1000
    jg InvalidInput

    call CheckEvenOdd
    call CheckPrime

    jmp ExitProgram

InvalidInput:
    push msg_invalid
    call printf
    add esp, 4

ExitProgram:
    xor eax, eax
    mov esp, ebp
    pop ebp
    ret

CheckEvenOdd:
    mov eax, [num]
    and eax, 1

    cmp eax, 0
    je PrintEven

PrintOdd:
    push msg_odd
    call printf
    add esp, 4
    ret

PrintEven:
    push msg_even
    call printf
    add esp, 4
    ret

CheckPrime:
    push ebx

    mov eax, [num]
    cmp eax, 2
    jl NotPrime

    mov ebx, 2

PrimeLoop:
    mov eax, ebx
    imul eax, ebx
    cmp eax, [num]
    jg IsPrime

    mov eax, [num]
    xor edx, edx
    div ebx

    cmp edx, 0
    je NotPrime

    inc ebx
    jmp PrimeLoop

IsPrime:
    push msg_prime
    call printf
    add esp, 4
    jmp PrimeDone

NotPrime:
    push msg_not
    call printf
    add esp, 4

PrimeDone:
    pop ebx
    ret
