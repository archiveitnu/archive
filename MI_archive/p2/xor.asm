global main
extern printf

section .data
    num1 dd 43
    num2 dd 11
    ans dd 0

    fmt db "XOR = %d",10,0

section .text
main:

    mov eax,[num1]
    xor eax,[num2]
    mov [ans],eax

    push dword [ans]
    push fmt
    call printf

    add esp,8

    mov eax,0
    ret