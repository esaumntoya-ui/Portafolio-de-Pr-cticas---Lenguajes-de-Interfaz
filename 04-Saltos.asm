; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 4. Saltos
; Descripción: Demuestra el uso de saltos incondicionales y condicionales
; evaluando distintas condiciones de igualdad, magnitud con signo y magnitud sin signo.

INCLUDE Irvine32.inc

.data
    msgNoDebe BYTE "Este mensaje no debe mostrarse",0       ; Texto que se omitira mediante un salto
    msgJmp BYTE "Salto incondicional realizado",0           ; Notificacion de salto ejecutado
    msgIgual BYTE "EAX y EBX son iguales",0                 ; Notificacion para valores identicos
    msgDistinto BYTE "EAX y EBX son distintos",0            ; Notificacion para valores diferentes
    msgMayor BYTE "EAX es mayor que EBX",0                  ; Notificacion de superioridad con signo
    msgMenor BYTE "EAX no es mayor que EBX",0               ; Notificacion de inferioridad con signo
    msgBajo BYTE "EAX es menor que EBX",0                   ; Notificacion de inferioridad sin signo
    msgNoBajo BYTE "EAX no es menor que EBX",0              ; Notificacion de superioridad sin signo

.code
main PROC
    ; Demostracion de salto incondicional
    jmp saltoIncondicional          ; Brinca directamente a la etiqueta saltando las siguientes lineas

    mov edx, OFFSET msgNoDebe       ; Carga la direccion del texto omitido
    call WriteString                ; Imprime el texto en pantalla
    call Crlf                       ; Realiza un salto de linea

saltoIncondicional:
    mov edx, OFFSET msgJmp          ; Prepara el texto indicando que el salto funciono
    call WriteString                
    call Crlf                       

    ; Evaluacion de igualdad entre dos registros
    mov eax, 10                     ; Asigna el primer valor
    mov ebx, 10                     ; Asigna el segundo valor
    cmp eax, ebx                    ; Ejecuta la comparacion
    je iguales                      ; Dirige el flujo a la etiqueta si los valores coinciden
    
    mov edx, OFFSET msgDistinto     ; Prepara el texto alternativo si son diferentes
    jmp mostrarIgualdad             ; Brinca a la impresion saltando la asignacion anterior

iguales:
    mov edx, OFFSET msgIgual        ; Prepara el texto confirmando la igualdad

mostrarIgualdad:
    call WriteString                ; Despliega el resultado de la evaluacion
    call Crlf                       

    ; Evaluacion de superioridad comparando valores con signo
    mov eax, 10                     ; Establece el valor a evaluar
    mov ebx, 5                      ; Establece el limite de comparacion
    cmp eax, ebx                    
    jg mayor                        ; Dirige el flujo si el primer valor es superior
    
    mov edx, OFFSET msgMenor        ; Prepara el texto alternativo
    jmp mostrarSigned               

mayor:
    mov edx, OFFSET msgMayor        ; Prepara el texto confirmando la superioridad

mostrarSigned:
    call WriteString                
    call Crlf                       

    ; Evaluacion de inferioridad comparando valores sin signo
    mov eax, 5                      
    mov ebx, 10                     
    cmp eax, ebx                    
    jb menorSinSigno                ; Dirige el flujo si el primer valor es estrictamente menor
    
    mov edx, OFFSET msgNoBajo       ; Prepara el texto alternativo
    jmp mostrarUnsigned             

menorSinSigno:
    mov edx, OFFSET msgBajo         ; Prepara el texto confirmando la inferioridad

mostrarUnsigned:
    call WriteString                
    call Crlf                       

    exit                            ; Termina la ejecucion
main ENDP
END main