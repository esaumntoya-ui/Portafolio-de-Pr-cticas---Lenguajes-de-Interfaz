; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 5. Condicionales (Ciclos anidados)
; Descripción: Utiliza dos registros como contadores para crear un ciclo anidado
; imprimiendo secuencias numericas en pantalla controladas por saltos condicionales.

INCLUDE Irvine32.inc

.code
main PROC

    mov eax, 1               ; Inicializa el primer contador
    mov ebx, 1               ; Inicializa el segundo contador

ciclo:
    cmp eax, 100             ; Evalua si el primer contador supero el limite
    jg ciclo2                ; Dirige el flujo a la segunda etapa si es mayor a cien
    
    call WriteDec            ; Imprime el numero actual en pantalla
    call Crlf                ; Inserta un salto de linea

    inc eax                  ; Suma uno al primer contador
    jmp ciclo                ; Retorna al inicio de la primera etapa para seguir imprimiendo

ciclo2:
    mov eax, ebx             ; Prepara el segundo contador moviendolo a EAX para impresion
    call WriteDec            ; Imprime el valor del segundo contador
    call Crlf                

    mov eax, 1               ; Restablece el primer contador a uno para la siguiente vuelta
    cmp ebx, 100             ; Evalua si el segundo contador ya alcanzo el limite maximo
    jg fin                   ; Termina la ejecucion si supero el cien

    inc ebx                  ; Suma uno al segundo contador
    jmp ciclo                ; Retorna a la primera etapa con los valores actualizados

fin:
    exit                     ; Finaliza el proceso y devuelve el control al sistema

main ENDP
END main