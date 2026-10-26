global main
extern printf
section .data
    str1 db "Hello I am Indian",0
    str2 db "Indian",0
    
    fmt db "%s",0
    
    str3 db "word found",10,0
    str4 db "word not found",10,0
    
section .text
main:
    
    mov esi, str1
    mov edi, str2
    
label1:
    cmp byte[esi], 0
    je notfound
    
    cmp esi, str1
    je check
    
    mov al, [esi-1]
    cmp al, ' '
    jne next
    
check:

    push esi
    push edi
    
label2:
    mov al, [esi]
    mov bl, [edi]
    
    cmp bl, 0
    je matched
    
    cmp al,bl
    jne notmatch
    
    inc esi
    inc edi
    jmp label2
    
matched:
    mov al, [esi]
    cmp al, 0
    je found
    
    cmp al, ' '
    je found
    
notmatch:
    pop edi
    pop esi
    
    
next:
    inc esi
    jmp label1
  
found:

    pop edi
    pop esi
    
    push str3
    push fmt
    call printf
    
    add esp, 8
    jmp end
    
notfound:

    pop edi
    pop esi
    
    push str4
    push fmt
    call printf
    
    add esp, 8
end:   
    ret