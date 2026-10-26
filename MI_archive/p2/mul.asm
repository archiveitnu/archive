global main
extern printf

section .data
    num1 dd 15
    num2 dd 4
    product dd 0

    fmt db "ans of multiplication = %d",10,0

section .text
main:

    mov eax,[num1]
    imul dword [num2]
    mov [product],eax

    push dword [product]
    push fmt
    call printf

    add esp,8

    mov eax,0
    ret