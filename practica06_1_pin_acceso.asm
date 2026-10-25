Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 6.1. Pin de acceso
; Descripción: Sistema de seguridad basico que solicita una contrasena numerica.
; Aplica un decremento controlado para limitar la cantidad de oportunidades
; a un maximo de tres antes de bloquear el acceso definitivamente.

INCLUDE Irvine32.inc

.data
    msgPIN      BYTE "Ingrese pin de acceso: ",0
    msgError    BYTE "Pin Incorrecto.",0
    msjAcceso   BYTE "Acceso Permitido.",0
    msgIntento  BYTE "Intentos Restantes: ",0
    msjBloqueo  BYTE "SISTEMA BLOQUEADO",0

    pinCorrecto = 1234              ; Valor numerico valido para ingresar

.code
main PROC
    mov ebx, 3                  ; Establece el limite de oportunidades al arrancar el programa

intento:                        ; Etiqueta principal para solicitar la clave
    mov edx, OFFSET msgPIN
    call WriteString            ; Muestra el texto pidiendo la informacion
    call ReadInt                ; Captura los numeros ingresados por teclado en el registro EAX

    cmp eax, pinCorrecto        ; Verifica si el numero digitado coincide con la clave guardada
    je acceso                   ; Concede paso libre si la validacion es correcta

    mov edx, OFFSET msgError    ; Prepara la notificacion de rechazo por clave erronea
    call WriteString
    call Crlf

    dec ebx                     ; Resta una oportunidad al contador general
    jz bloqueado                ; Dirige al estado de bloqueo total al agotar los turnos

    mov edx, OFFSET msgIntento  ; Avisa cuantas oportunidades le sobran al usuario
    call WriteString
    mov eax, ebx
    call WriteDec               ; Imprime la cantidad actual almacenada en el contador
    call Crlf

    jmp intento                 ; Retorna arriba para que el usuario teclee nuevamente

acceso:                         ; Seccion ejecutada cuando la clave es acertada
    mov edx, OFFSET msjAcceso
    call WriteString
    call Crlf
    jmp fin

bloqueado:                      ; Seccion ejecutada al equivocarse tres veces seguidas
    mov edx, OFFSET msjBloqueo
    call WriteString
    call Crlf

fin:
    exit
main ENDP

END main