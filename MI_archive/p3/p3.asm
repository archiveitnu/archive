global main
extern printf
extern scanf

section .data
  msgdest db "Select the Destination Register",10
  db "0=AX  1=CX  2=DX  3=BX  4=SP  5=BP  6=SI  7=DI: ",10,0

  msgsrc db "Select the Source Register",10
  db "0=AX  1=CX  2=DX  3=BX  4=SP  5=BP  6=SI  7=DI: ",10,0

  fmtIn db "%d",0
  fmtOut db 10,"Machine Code : 89 %02X",10,0

section .bss
  dest resd 1
  src resd 1
  mcode resd 1

section .text
  main:
    mov ebp, esp; for correct debugging

    push msgdest
    call printf
    add esp,4

    push dest
    push fmtIn
    call scanf
    add esp,8

    push msgsrc
    call printf
    add esp,4

    push src
    push fmtIn
    call scanf
    add esp,8

    mov eax,3
    shl eax,6 

    mov ebx,[src]
    shl ebx,3 
    add eax,ebx

    mov ebx,[dest]
    add eax,ebx 

    mov [mcode],eax

    push dword [mcode]
    push fmtOut
    call printf
    add esp,8

    mov eax,0
    ret