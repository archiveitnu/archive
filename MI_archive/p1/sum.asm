global main 
extern printf 

section .data 
    num1 dd 11 
    num2 dd 28 
    sum  dd 0 
    fmt db "Sum = %d",10,0 

section .text 
main:    
    mov eax,[num1] 
    add eax,[num2] 
    mov [sum],eax 
    push dword [sum] 
    push fmt 
    call printf 
    add esp,8 
    mov eax,0 
    ret 