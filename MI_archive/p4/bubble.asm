section .data 

  

    arr db 2, 8, 19, 30, 22, 12, 20, 10 

    fmt db "%d ", 0 

  

section .text 

  

    global main 

    extern printf 

  

main: 

  

    mov edx, 7               

  

outer_loop: 

                 

  

    mov esi, arr             

    mov ecx, 7                

  

inner_loop: 

  

    mov al, [esi]             

    mov bl, [esi+1]           

  

    cmp al, bl 

    jle no_swap                

  

    mov [esi], bl 

    mov [esi+1], al 

  

no_swap: 

  

    inc esi                  

  

    loop inner_loop 

    dec edx 

jnz outer_loop 

  

    mov esi, arr 

    mov ecx, 8 

  

print_loop: 

  

    movzx eax, byte [esi] 

  

    push ecx 

    push esi 

  

    push eax 

    push fmt 

    call printf 

    add esp, 8 

  

    pop esi 

    pop ecx 

  

    inc esi 

    loop print_loop 

  

    ret 