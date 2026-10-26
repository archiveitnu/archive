global main
extern printf

section .data
    num1 dd 24
    num2 dd 4
    quotient dd 0

    fmt db "Quotient = %d",10,0

section .text
main:

    mov eax,[num1]
    cdq
    idiv dword [num2]
    mov [quotient],eax

    push dword [quotient]
    push fmt
    call printf

    add esp,8

    mov eax,0
    ret