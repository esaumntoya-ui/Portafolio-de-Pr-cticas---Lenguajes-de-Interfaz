; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 3. Comparación y prueba
; Descripción: Evalua el comportamiento de las banderas del procesador
; al ejecutar instrucciones de comparacion y prueba logica con diferentes valores.

INCLUDE Irvine32.inc

.data
    ; No se requieren variables en memoria para esta practica

.code
main PROC

    ; Primer escenario activacion de la bandera de cero ZF
    mov eax, 10h            ; Carga el valor base en el registro
    cmp eax, 10h            ; Realiza la comparacion con un valor identico
    call DumpRegs           ; Imprime el estado de las banderas comprobando ZF en uno

    ; Segundo escenario activacion de la bandera de signo SF
    mov eax, 0              ; Reinicia el registro EAX
    mov ebx, 0              ; Reinicia el registro EBX

    mov al, -5              ; Establece un valor negativo
    mov bl, 1               ; Establece un valor positivo
    cmp al, bl              ; Compara ambos valores
    call DumpRegs           ; Muestra el resultado de la bandera de signo

    ; Tercer escenario activacion de la bandera de acarreo CF
    mov eax, 0              ; Limpia el registro EAX
    mov ebx, 0              ; Limpia el registro EBX

    mov al, 5               ; Asigna el primer valor
    mov bl, 10              ; Asigna un valor mayor al segundo registro
    cmp al, bl              ; Realiza la comparacion que genera un acarreo
    call DumpRegs           ; Imprime las banderas para verificar CF en uno

    ; Cuarto escenario activacion de la bandera de desbordamiento OF
    mov eax, 0              ; Prepara el registro EAX
    mov ebx, 0              ; Prepara el registro EBX

    mov al, -128            ; Asigna el limite inferior de un byte con signo
    mov bl, 1               ; Asigna el valor a comparar
    cmp al, bl              ; Ejecuta la comparacion provocando desbordamiento
    call DumpRegs           ; Confirma el estado de la bandera OF

    ; Quinto escenario comprobacion de bits con la instruccion TEST
    mov eax, 0              ; Vacia el registro principal
    mov eax, 5              ; Carga el numero cinco
    test eax, 1             ; Evalua si el bit menos significativo esta encendido
    call DumpRegs           ; Visualiza las banderas resultantes

    mov eax, 0              ; Restablece el registro a cero
    mov eax, 10000000b      ; Inserta un dato en formato binario
    test eax, 10000000b     ; Aplica la prueba logica sobre el bit mas significativo
    call DumpRegs           ; Despliega el estado final de los registros

    exit

main ENDP
END main