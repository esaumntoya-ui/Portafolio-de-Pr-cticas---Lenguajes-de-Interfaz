; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 5. Repetir hasta que el usuario ingrese cero
; Descripción: El programa utiliza un ciclo condicional que solicita y 
; lee repetidamente un número ingresado por el usuario, finalizando 
; su ejecución únicamente cuando se ingresa el valor cero.

INCLUDE Irvine32.inc

.data
    prompt BYTE "Ingresa un numero (0 para salir): ",0
    despedida BYTE "Programa terminado. Has ingresado cero.",0

.code
main PROC
ciclo:                  ; Etiqueta de inicio del ciclo
    ; Solicita al usuario ingresar un número
    mov edx, OFFSET prompt
    call WriteString
    
    ; Captura el número ingresado (el resultado se guarda en EAX)
    call ReadInt
    
    ; Comparación para la condición de salida
    cmp eax, 0          ; Compara el valor ingresado con 0
    je fin              ; Si es igual a 0, salta a la etiqueta 'fin'
    
    ; Si el número no es 0, repite el ciclo
    jmp ciclo           ; Salto incondicional al inicio

fin:                    ; Etiqueta de salida del programa
    ; Despliega mensaje de despedida
    mov edx, OFFSET despedida
    call WriteString
    call Crlf           ; Salto de línea
    exit
main ENDP

END main