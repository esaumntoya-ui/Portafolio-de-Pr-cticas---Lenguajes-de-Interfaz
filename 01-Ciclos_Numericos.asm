; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: Extra (Hola Mundo)
; Descripción: Programa basico que demuestra la impresion de una cadena de texto
; en consola utilizando un contador y un ciclo de repeticion.

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Hola mundo", 0   ; Cadena de texto que se mostrara en pantalla

.code
main PROC

    mov ecx, 1                  ; Establece el contador del ciclo para que se ejecute una sola vez
    mov edx, OFFSET mensaje     ; Carga la direccion de memoria del mensaje en el registro EDX

ciclo:                          ; Etiqueta que marca el inicio de las repeticiones
    call WriteString            ; Imprime los caracteres hasta encontrar el terminador nulo
    call Crlf                   ; Inserta un salto de linea para separar el texto
    loop ciclo                  ; Decrementa ECX y repite si el contador no ha llegado a cero

    exit                        ; Finaliza la ejecucion del programa

main ENDP
END main
