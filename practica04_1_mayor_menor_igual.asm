Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 4.1. Mayor, menor o igual con entrada del usuario
; Descripción: El programa captura dos números ingresados por el usuario, 
; los compara y despliega un mensaje indicando si el primero es mayor, menor o igual al segundo.

INCLUDE Irvine32.inc

.data
    num1 BYTE "Ingresa el primer numero: ",0
    num2 BYTE "Ingresa el segundo numero: ",0
    igualMsg BYTE "Los numeros son iguales",0
    mayorMsg BYTE "El primer numero es mayor",0
    menorMsg BYTE "El primer numero es menor",0

.code
main PROC
    ; Captura del primer número
    mov edx, OFFSET num1
    call WriteString
    call ReadInt
    mov ebx, eax          ; Se guarda el primer número en EBX

    ; Captura del segundo número
    mov edx, OFFSET num2
    call WriteString
    call ReadInt          ; El segundo número queda en EAX

    ; Comparación y saltos condicionales
    cmp ebx, eax          ; Compara EBX (primer num) con EAX (segundo num)
    je iguales            ; Salta a 'iguales' si son iguales
    jg mayor              ; Salta a 'mayor' si EBX > EAX
    jl menor              ; Salta a 'menor' si EBX < EAX

iguales:
    mov edx, OFFSET igualMsg
    call WriteString
    jmp salir             ; Salto incondicional para evitar ejecutar el resto

mayor:
    mov edx, OFFSET mayorMsg
    call WriteString
    jmp salir             ; Salto incondicional al final

menor:
    mov edx, OFFSET menorMsg
    call WriteString

salir:
    call Crlf
    exit

main ENDP
END main