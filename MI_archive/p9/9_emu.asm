.MODEL SMALL
.STACK 100H

.DATA
    msg1 DB 'Enter number of terms (1 to 20): $'
    msg2 DB 13,10,'Fibonacci Series: $'
    msg3 DB 13,10,'Invalid input! Enter 1 to 20.$'
    space DB ' $'
    newline DB 13,10,'$'

    N DW 0
    A DW 0
    B DW 1
    C DW 0
    COUNT DW 0

.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    LEA DX, msg1
    MOV AH, 09H
    INT 21H

    MOV AH, 01H
    INT 21H
    SUB AL, '0'
    MOV BL, AL

    MOV AH, 01H
    INT 21H

    CMP AL, 13
    JE ONE_DIGIT

    SUB AL, '0'
    MOV BH, AL

    MOV AL, BL
    MOV AH, 0
    MOV CL, 10
    MUL CL

    ADD AL, BH
    MOV AH, 0
    MOV N, AX
    JMP CHECK_INPUT

ONE_DIGIT:
    MOV AL, BL
    MOV AH, 0
    MOV N, AX

CHECK_INPUT:
    MOV AX, N
    CMP AX, 1
    JL INVALID
    CMP AX, 20
    JG INVALID

    LEA DX, msg2
    MOV AH, 09H
    INT 21H

    CALL Fibonacci

    JMP FINISH

INVALID:
    LEA DX, msg3
    MOV AH, 09H
    INT 21H

FINISH:
    MOV AH, 4CH
    INT 21H

MAIN ENDP

Fibonacci PROC NEAR

    MOV A, 0
    MOV B, 1
    MOV AX, N
    MOV COUNT, AX

NEXT_TERM:
    MOV AX, A
    CALL PRINT_NUMBER

    MOV DL, ' '
    MOV AH, 02H
    INT 21H

    MOV AX, A
    ADD AX, B
    MOV C, AX

    MOV AX, B
    MOV A, AX

    MOV AX, C
    MOV B, AX

    DEC COUNT
    JNZ NEXT_TERM

    LEA DX, newline
    MOV AH, 09H
    INT 21H

    RET

Fibonacci ENDP

PRINT_NUMBER PROC NEAR

    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX

    MOV BX, 10
    XOR CX, CX

    CMP AX, 0
    JNE CONVERT

    MOV DL, '0'
    MOV AH, 02H
    INT 21H
    JMP PRINT_DONE

CONVERT:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNE CONVERT

PRINT_DIGITS:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    LOOP PRINT_DIGITS

PRINT_DONE:
    POP DX
    POP CX
    POP BX
    POP AX
    RET

PRINT_NUMBER ENDP

END MAIN