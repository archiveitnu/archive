section .data
    input db 100 dup(0)

    infmt db "%99s", 0
    fmt_num db "%d ", 0
    fmt_char db "Character: %c", 10, 0

    msg_string db "ASCII: ", 0
    newline db 10, 0

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

    movzx eax, byte [esi]

    cmp eax, 0
    je check_done

    cmp eax, '0'
    jb string_input

    cmp eax, '9'
    ja string_input

    inc esi
    inc ecx
    jmp check_input

check_done:

    push input
    call ascii_to_char
    add esp, 4
    jmp done


string_input:

    push input
    call string_to_ascii
    add esp, 4

done:
    ret


string_to_ascii:

    push ebp
    mov ebp, esp

    mov esi, [ebp+8]

    push msg_string
    call printf
    add esp, 4

print_ascii:

    movzx eax, byte [esi]

    cmp eax, 0
    je string_done

    push esi
    push eax
    push fmt_num
    call printf
    add esp, 8
    pop esi

    inc esi
    jmp print_ascii

string_done:

    push newline
    call printf
    add esp, 4

    pop ebp
    ret


ascii_to_char:

    push ebp
    mov ebp, esp

    mov esi, [ebp+8]

    xor eax, eax

convert_number:

    movzx ebx, byte [esi]

    cmp ebx, 0
    je number_done

    sub ebx, '0'

    imul eax, eax, 10
    add eax, ebx

    inc esi
    jmp convert_number

number_done:

    push eax
    push fmt_char
    call printf
    add esp, 8

    pop ebp
    ret