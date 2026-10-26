global main
extern printf
  
section .data
    num1 dd 15
    num2 dd 18
    ans dd 0

    fmt db "AND = %d",10,0

section .text
main:

    mov eax,[num1]
      AND eax,[num2]
    mov [ans],eax

    push dword [ans]
    push fmt
    call printf

    add esp,8

    mov eax,0
    ret