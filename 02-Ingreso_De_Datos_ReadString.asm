; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: Extra (Captura de nombre y longitud)
; Descripción: El programa pide al usuario que escriba su nombre
; lo lee desde el teclado y muestra en pantalla tanto el texto ingresado
; como la cantidad total de caracteres escritos.

INCLUDE Irvine32.inc

.data
    mensajeEntrada BYTE "Escribe tu nombre: ", 0            
    nombre BYTE 10 DUP(0)                                   
    caracteresEscritos BYTE "Numero de caracteres: ", 0     

.code
main PROC
    ; Despliega el mensaje solicitando la informacion del usuario
    mov edx, OFFSET mensajeEntrada
    call WriteString

    ; Configura el espacio en memoria y el limite de caracteres permitidos
    mov edx, OFFSET nombre
    mov ecx, SIZEOF nombre
    call ReadString                     ; Captura el texto y guarda la longitud en EAX

    ; Imprime el texto introducido por el usuario
    mov edx, OFFSET nombre
    call WriteString
    call Crlf

    ; Imprime la etiqueta explicativa
    mov edx, OFFSET caracteresEscritos  ; Nombre de variable corregido
    call WriteString
    
    ; EAX ya contiene la longitud devuelta por ReadString
    call WriteDec                       ; Despliega la cantidad de caracteres
    call Crlf
    
    exit
main ENDP
END main