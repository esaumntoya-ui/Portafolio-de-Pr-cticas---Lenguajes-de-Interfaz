; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 8. Operaciones aritméticas
; Descripción: Ejecuta rutinas de calculo matematico a nivel de procesador.
; Abarca sumas restas multiplicaciones y divisiones tanto con signo como sin signo
; ademas de comprobar el comportamiento de las banderas de acarreo y desbordamiento.

INCLUDE Irvine32.inc

.code
main PROC

    ; Primer bloque demuestra la suma y resta basica
    mov eax, 50       ; Asigna el valor inicial de cincuenta al registro principal
    mov ebx, 20       ; Asigna el sumando de veinte al registro secundario
    add eax, ebx      ; Ejecuta la adicion almacenando el total en el primer registro
    sub eax, 15       ; Sustrae quince unidades al resultado calculado
    nop               ; Pausa la ejecucion un ciclo de reloj para separar bloques

    ; Segundo bloque comprueba el acarreo en operaciones sin signo
    mov eax, 0        ; Vacia completamente el registro EAX
    mov al, 255       ; Asigna el limite maximo para ocho bits sin considerar el signo
    add al, 1         ; Fuerza la activacion de la bandera CF al exceder la capacidad

    ; Tercer bloque demuestra el desbordamiento en operaciones con signo
    mov eax, 0        ; Limpia nuevamente el registro
    mov al, 127       ; Asigna el limite maximo positivo para ocho bits con signo
    add al, 1         ; Activa la bandera OF al alterar la estructura del signo
    nop               

    ; Cuarto bloque ejecuta multiplicaciones
    mov eax, 65532    ; Establece el primer factor para multiplicar
    mov ebx, 65532    ; Establece el segundo factor
    mul ebx           ; Multiplica sin signo expandiendo el resultado hacia EDX y EAX

    mov eax, -5       ; Carga un numero negativo para la siguiente operacion
    imul eax, eax, 3  ; Multiplica respetando el signo utilizando tres operandos
    nop               

    ; Quinto bloque realiza una division estandar sin signo
    mov eax, 125      ; Carga el dividendo en la parte baja
    mov edx, 0        ; Limpia la parte alta ya que la division toma ambos registros
    mov ebx, 12       ; Establece el divisor
    div ebx           ; Efectua el calculo dejando el cociente en EAX y residuo en EDX
    nop               

    ; Sexto bloque procesa una division matematica conservando los signos
    mov eax, -125     ; Inserta el dividendo negativo
    cdq               ; Extiende automaticamente el signo de EAX hacia EDX
    mov ebx, 12       ; Define el divisor
    idiv ebx          ; Ejecuta la division evaluando signos correctamente
    nop               

    exit              ; Concluye la ejecucion y devuelve el control

main ENDP
END main