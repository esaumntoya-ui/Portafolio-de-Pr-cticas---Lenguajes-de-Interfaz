; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 11. Operaciones lógicas
; Descripción: Demuestra la manipulacion de bits empleando compuertas logicas 
; para simular y modificar los estados operativos de una computadora.
; Aplica instrucciones como AND OR XOR y TEST sobre registros especificos.

INCLUDE Irvine32.inc

; Posiciones de bits para los estados del equipo
; Bit cero controla el encendido del equipo
; Bit uno controla la activacion de la alarma
; Bit dos indica si existe conexion a la red
; Estado base simulado 00000101

.data
    tInicial BYTE "Estado inicial: 00000101 (encendida, sin alarma, conectada)", 0
    tAnd     BYTE "1 AND con 00000010b (aisla el bit de alarma): ", 0
    tOr      BYTE "2 OR con 00000010b (enciende la alarma): ", 0
    tXor1    BYTE "3 XOR con 00000001b (apaga la computadora): ", 0
    tXor2    BYTE "3 XOR con 00000001b (la vuelve a encender): ", 0
    tTest1   BYTE "4 TEST con estado 00000111b: ", 0
    tTest2   BYTE "4 TEST con estado 00000101b: ", 0
    msgOn    BYTE "alarma encendida", 0
    msgOff   BYTE "alarma apagada", 0

.code
main PROC
    ; Imprime el contexto original antes de iniciar las modificaciones
    mov edx, OFFSET tInicial
    call WriteString
    call Crlf
    call Crlf

    ; Primera fase Aisla el bit de la alarma para revisar su valor actual
    mov edx, OFFSET tAnd
    call WriteString
    mov al, 00000101b
    and al, 00000010b
    call MostrarBits

    ; Segunda fase Enciende la alarma forzando el bit correspondiente a uno
    mov edx, OFFSET tOr
    call WriteString
    mov al, 00000101b
    or al, 00000010b
    call MostrarBits

    ; Tercera fase Apaga el equipo invirtiendo el valor del bit de encendido
    mov edx, OFFSET tXor1
    call WriteString
    mov al, 00000101b
    xor al, 00000001b
    call MostrarBits

    ; Cuarta fase Vuelve a encender el equipo invirtiendo el bit nuevamente
    mov edx, OFFSET tXor2
    call WriteString
    xor al, 00000001b
    call MostrarBits

    call Crlf

    ; Quinta fase Evalua un estado con la alarma activa sin alterar el registro
    mov edx, OFFSET tTest1
    call WriteString
    mov al, 00000111b
    test al, 00000010b
    jz alarmaApagadaA           ; Salta a la etiqueta de apagado si el resultado es cero
    mov edx, OFFSET msgOn
    jmp imprimirA               ; Brinca directo a la impresion para omitir el otro mensaje

alarmaApagadaA:
    mov edx, OFFSET msgOff      ; Prepara el texto indicando que esta desactivada

imprimirA:
    call WriteString
    call Crlf

    ; Sexta fase Evalua un estado con la alarma inactiva
    mov edx, OFFSET tTest2
    call WriteString
    mov al, 00000101b
    test al, 00000010b
    jz alarmaApagadaB           ; Dirige el flujo al texto de apagado por encontrar un cero
    mov edx, OFFSET msgOn
    jmp imprimirB

alarmaApagadaB:
    mov edx, OFFSET msgOff

imprimirB:
    call WriteString
    call Crlf

    exit
main ENDP

MostrarBits PROC
    ; Subrutina dedicada a imprimir un registro en formato binario
    push eax                    ; Protege el contenido original
    push ebx                    ; Protege el contenido original
    movzx eax, al               ; Extiende el valor de un byte para llenar el registro completo
    mov ebx, TYPE BYTE          ; Especifica el tamano de la estructura a procesar
    call WriteBinB              ; Despliega los ceros y unos en pantalla
    call Crlf
    pop ebx                     ; Restaura el valor respaldado
    pop eax                     ; Restaura el valor respaldado
    ret                         ; Devuelve el control a la rutina llamadora
MostrarBits ENDP

END main