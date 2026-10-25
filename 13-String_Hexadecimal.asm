; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 13. Obtención de una cadena hexadecimal
; Descripción: Convierte un valor numerico de treinta y dos bits a su representacion
; en texto hexadecimal procesando el registro en bloques de cuatro bits mediante
; desplazamientos e insertando los caracteres correspondientes en un arreglo.

INCLUDE Irvine32.inc

.data
    valor DWORD 12AB34CDh           ; Cantidad numerica base para realizar la conversion
    bufferHex BYTE 9 DUP(0)         ; Arreglo de memoria para los ocho caracteres y el terminador
    msgHex BYTE "Valor en hexadecimal: ",0 

.code
main PROC
    mov eax, valor                  ; Traspasa la cantidad numerica al registro de trabajo
    mov esi, 7                      ; Apunta al ultimo espacio util del arreglo de texto
    mov ecx, 8                      ; Define las ocho vueltas necesarias para procesar el registro completo

ciclo:
    mov ebx, eax                    ; Crea un respaldo temporal del dato en proceso
    and ebx, 0Fh                    ; Aisla los cuatro bits menos significativos del bloque

    cmp ebx, 10                     ; Comprueba si el fragmento corresponde a un numero decimal
    jb esDigito                     ; Redirige el flujo si el valor esta entre cero y nueve
    sub ebx, 10                     ; Ajusta el fragmento para alinearlo con las letras correspondientes
    add ebx, 'A'                    ; Transforma el dato en una letra mayuscula del sistema base dieciseis
    jmp guardar                     ; Omite la suma decimal y pasa directo a la insercion en memoria

esDigito:
    add ebx, '0'                    ; Convierte el valor numerico en un caracter ascii imprimible

guardar:
    mov bufferHex[esi], bl          ; Deposita el caracter obtenido en la posicion actual del arreglo
    shr eax, 4                      ; Recorre los bits del registro para procesar el siguiente fragmento
    dec esi                         ; Mueve el puntero hacia la izquierda para acomodar el proximo caracter
    loop ciclo                      ; Repite las instrucciones hasta vaciar el contador general

    mov bufferHex[8], 0             ; Asegura la terminacion correcta de la cadena de texto con un nulo

    mov edx, OFFSET msgHex          
    call WriteString                ; Imprime la etiqueta descriptiva en consola
    mov edx, OFFSET bufferHex       
    call WriteString                ; Despliega el resultado final de la conversion en pantalla
    call Crlf                       

    exit                            ; Concluye la ejecucion de manera segura
main ENDP
END main