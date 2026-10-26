global main
extern printf

section .data
    num1 dd 11
    num2 dd 17
    sub1 dd 0

    fmt db "Diff = %d",10,0

section .text
main:

    mov eax,[num1]
    sub eax,[num2]
    mov [sub1],eax

    push dword [sub1]
    push fmt
    call printf

    add esp,8

    mov eax,0
    ret