; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 12. Desplazamiento y rotación
; Descripción: Implementacion de instrucciones a nivel de bits para mover y rotar
; posiciones binarias. Se observan los efectos en la bandera de acarreo y
; las diferencias entre movimientos logicos aritmeticos y rotaciones circulares.

INCLUDE Irvine32.inc

.data
    t1     BYTE "1 SHL 1 (izquierda, multiplica por 2):", 0
    t2     BYTE "2 SHR 1 (derecha, divide entre 2):", 0
    t3     BYTE "3 SAR 1 (derecha con signo, AL = -9):", 0
    t4     BYTE "4 SHL con constante 2 (multiplica por 4):", 0
    t5     BYTE "5 SHR con CL = 2 (divide entre 4):", 0
    t6     BYTE "6 ROL 1 (rota a la izquierda):", 0
    t7     BYTE "7 ROR 1 (rota a la derecha):", 0
    t8     BYTE "8 RCL 1 dos veces (rota con acarreo, CF inicia en 0):", 0
    t9     BYTE "9 RCR 1 dos veces (rota con acarreo, CF inicia en 0):", 0
    sAntes BYTE "   antes : ", 0
    sDesp  BYTE "   despues: ", 0
    sCF    BYTE "  CF = ", 0
    sDec   BYTE "  decimal = ", 0

.code
main PROC
    ; Primer bloque recorre un bit a la izquierda para multiplicar por dos
    mov edx, OFFSET t1
    call Titulo                 ; Despliega el rotulo informativo
    mov al, 10000010b           ; Establece el valor inicial
    call Antes                  ; Muestra el binario original
    shl al, 1                   ; Empuja los bits a la izquierda llenando con ceros a la derecha
    call Despues                ; Imprime el nuevo valor

    ; Segundo bloque recorre un bit a la derecha para dividir entre dos
    mov edx, OFFSET t2
    call Titulo
    mov al, 00001100b
    call Antes
    shr al, 1                   ; Empuja los bits a la derecha llenando con ceros a la izquierda
    call Despues

    ; Tercer bloque recorre a la derecha manteniendo el bit de signo
    mov edx, OFFSET t3
    call Titulo
    mov al, -9                  ; Guarda un numero negativo
    call Antes
    sar al, 1                   ; Divide entre dos conservando el valor negativo original
    call Despues
    mov edx, OFFSET sDec
    call WriteString
    movsx eax, al               ; Expande el registro manteniendo el signo para imprimirlo
    call WriteInt
    call Crlf

    ; Cuarto bloque recorre multiples posiciones usando un valor constante
    mov edx, OFFSET t4
    call Titulo
    mov al, 00001100b
    call Antes
    shl al, 2                   ; Recorre dos lugares a la izquierda multiplicando por cuatro
    call Despues

    ; Quinto bloque recorre multiples posiciones tomando el valor del registro CL
    mov edx, OFFSET t5
    call Titulo
    mov al, 00010100b
    mov cl, 2                   ; Especifica la cantidad de movimientos
    call Antes
    shr al, cl                  ; Divide entre cuatro usando el contador
    call Despues

    ; Sexto bloque mueve los bits en forma circular hacia la izquierda
    mov edx, OFFSET t6
    call Titulo
    mov al, 10010001b
    call Antes
    rol al, 1                   ; El bit saliente por la izquierda reingresa por la derecha
    call Despues

    ; Septimo bloque mueve los bits en forma circular hacia la derecha
    mov edx, OFFSET t7
    call Titulo
    mov al, 00010011b
    call Antes
    ror al, 1                   ; El bit saliente por la derecha reingresa por la izquierda
    call Despues

    ; Octavo bloque rota a la izquierda incluyendo la bandera de acarreo
    mov edx, OFFSET t8
    call Titulo
    clc                         ; Limpia la bandera de acarreo forzando un cero
    mov al, 10000001b
    call Antes
    rcl al, 1                   ; Rota un lugar insertando el valor previo de la bandera
    call Despues
    rcl al, 1                   ; Rota nuevamente para ver como cambia el acarreo
    call Despues

    ; Noveno bloque rota a la derecha incluyendo la bandera de acarreo
    mov edx, OFFSET t9
    call Titulo
    clc                         ; Asegura que el acarreo comience vacio
    mov al, 00000011b
    call Antes
    rcr al, 1                   ; Circula hacia la derecha pasando por la bandera
    call Despues
    rcr al, 1
    call Despues

    exit
main ENDP

Titulo PROC
    ; Subrutina auxiliar para imprimir espacio y texto de encabezado
    call Crlf
    call WriteString
    call Crlf
    ret
Titulo ENDP

Antes PROC
    ; Subrutina que imprime la etiqueta y los bits antes de operarlos
    push edx                    ; Guarda temporalmente la direccion de la cadena principal
    mov edx, OFFSET sAntes
    call WriteString
    pop edx                     ; Recupera la direccion para no afectar al bloque principal
    call MostrarAL
    ret
Antes ENDP

Despues PROC
    ; Subrutina que imprime la etiqueta y los bits ya procesados
    push edx
    mov edx, OFFSET sDesp
    call WriteString
    pop edx
    call MostrarAL
    ret
Despues ENDP

MostrarAL PROC
    ; Subrutina compleja para imprimir binarios y el estado del acarreo
    pushfd                      ; Respalda todas las banderas del procesador
    push eax
    push ebx
    push edx
    push esi

    setc bl                     ; Copia el estado de la bandera de acarreo al registro BL
    movzx esi, bl               ; Mueve el valor a ESI limpiando el resto de los bits

    movzx eax, al               ; Prepara EAX con el dato a imprimir
    mov ebx, TYPE BYTE          ; Define la longitud a procesar
    call WriteBinB              ; Escribe la representacion binaria

    mov edx, OFFSET sCF
    call WriteString
    mov eax, esi                ; Recupera el estado del acarreo para imprimirlo
    call WriteDec
    call Crlf

    pop esi                     ; Devuelve los registros a su estado previo
    pop edx
    pop ebx
    pop eax
    popfd                       ; Restaura las banderas originales
    ret
MostrarAL ENDP

END main