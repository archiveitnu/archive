section .data
    arr dd 10 dup(0)
    fmt_in db "%d", 0
    fmt_out db "Sum = %d, Average = %d", 10, 0

section .text
    global main
    extern printf
    extern scanf

main:
    mov esi, arr
    mov ecx, 10

input_loop:
    push ecx
    push esi
    push fmt_in
    call scanf
    add esp, 8
    pop ecx

    inc esi
    loop input_loop

    mov esi, arr
    mov ecx, 10
    xor ebx, ebx

loop_sum:
    movzx eax, byte [esi]
    add ebx, eax
    inc esi
    loop loop_sum

    mov eax, ebx
    xor edx, edx
    mov ecx, 10
    div ecx

    push eax
    push ebx
    push fmt_out
    call printf
    add esp, 12

    ret