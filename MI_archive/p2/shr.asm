global main
extern printf

section .data
    num1 dd 9
    ans dd 0

    fmt db "ans after SHR = %d",10,0

section .text
main:

    mov eax,[num1]
    SHR eax,3
    
    mov [ans],eax

    push dword [ans]
    push fmt
    call printf

    add esp,8

    mov eax,0
    ret