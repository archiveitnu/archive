global main
extern printf

section .data
     str1 db "hello world",0
     fmt  db  "%s",10,0
   
section .text  
main:
     
     push str1
     push fmt
     call printf
     
     add esp,8
     
     mov eax,0
     
  
    ret