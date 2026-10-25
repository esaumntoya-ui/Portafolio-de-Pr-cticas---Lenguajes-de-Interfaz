; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 7. Validación de formato
; Descripción: Evalua una cadena de caracteres ingresada por el usuario para
; verificar que cumpla con un patron especifico de tres letras mayusculas,
; un simbolo separador y tres numeros consecutivos.

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Ingrese el codigo: ",0
    valido BYTE "Formato valido",0
    invalido BYTE "Formato invalido",0

    cadena BYTE 20 DUP(0)

.code
main PROC

    ; Solicita al usuario teclear la informacion requerida
    mov edx, OFFSET mensaje
    call WriteString

    ; Configura el limite de lectura y guarda la respuesta en memoria
    mov edx, OFFSET cadena
    mov ecx, 19
    call ReadString

    ; Verifica que la cantidad total de caracteres escritos sea exactamente siete
    cmp eax, 7
    jne fallo

    ; Revisa que la primera posicion contenga una letra mayuscula
    mov al, cadena[0]
    cmp al, 'A'
    jb fallo
    cmp al, 'Z'
    ja fallo

    ; Revisa que la segunda posicion contenga una letra mayuscula
    mov al, cadena[1]
    cmp al, 'A'
    jb fallo
    cmp al, 'Z'
    ja fallo

    ; Revisa que la tercera posicion contenga una letra mayuscula
    mov al, cadena[2]
    cmp al, 'A'
    jb fallo
    cmp al, 'Z'
    ja fallo

    ; Confirma la existencia del simbolo separador en la cuarta posicion
    mov al, cadena[3]
    cmp al, '-'
    jne fallo

    ; Comprueba que la quinta posicion corresponda a un digito numerico
    mov al, cadena[4]
    cmp al, '0'
    jb fallo
    cmp al, '9'
    ja fallo

    ; Comprueba que la sexta posicion corresponda a un digito numerico
    mov al, cadena[5]
    cmp al, '0'
    jb fallo
    cmp al, '9'
    ja fallo

    ; Comprueba que la septima posicion corresponda a un digito numerico
    mov al, cadena[6]
    cmp al, '0'
    jb fallo
    cmp al, '9'
    ja fallo

    ; Notifica en pantalla que la estructura de la cadena es correcta
    mov edx, OFFSET valido
    call WriteString
    jmp salir

fallo:
    ; Notifica al usuario que el texto no cumple con las reglas establecidas
    mov edx, OFFSET invalido
    call WriteString

salir:
    call Crlf
    exit

main ENDP
END main