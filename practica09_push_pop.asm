Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 9. PUSH y POP
; Descripción: Demostracion practica del uso de la pila del sistema.
; Ejemplifica operaciones de insercion y extraccion, el principio basico LIFO,
; la proteccion de informacion en registros y el llamado a subrutinas.

INCLUDE Irvine32.inc

.data
    tBloque1 BYTE "BLOQUE 1: PUSH Y POP (EBX debe quedar en 40)", 0
    tBloque2 BYTE "BLOQUE 2: ORDEN LIFO (EAX=30, EBX=20, ECX=10)", 0
    tBloque3 BYTE "BLOQUE 3: CONSERVAR REGISTROS (EAX=100, EBX=200)", 0
    tBloque4 BYTE "BLOQUE 4: CALL Y RET (EAX=60, EBX=100)", 0

.code
main PROC
    ; Primer escenario para probar insercion y extraccion basica
    mov edx, OFFSET tBloque1
    call MostrarTitulo

    mov eax, 40
    push eax                    ; Coloca el contenido de EAX en el tope de la pila
    nop                         ; Operacion sin efecto para separar instrucciones

    mov eax, 0
    pop ebx                     ; Saca el valor superior de la pila hacia el registro EBX
    nop
    call DumpRegs               ; Imprime el estado actual de los registros

    ; Segundo escenario para comprobar la naturaleza LIFO de la pila
    mov edx, OFFSET tBloque2
    call MostrarTitulo

    mov eax, 10
    push eax                    ; Inserta el primer elemento
    mov eax, 20
    push eax                    ; Inserta el segundo elemento
    mov eax, 30
    push eax                    ; Inserta el tercer elemento en la cima
    nop

    pop eax                     ; Recupera el ultimo elemento ingresado
    pop ebx                     ; Recupera el penultimo elemento ingresado
    pop ecx                     ; Recupera el primer elemento ingresado
    nop
    call DumpRegs

    ; Tercer escenario para respaldar y recuperar informacion
    mov edx, OFFSET tBloque3
    call MostrarTitulo

    mov eax, 100
    mov ebx, 200

    push eax                    ; Respalda temporalmente el valor de EAX
    push ebx                    ; Respalda temporalmente el valor de EBX

    mov eax, 999                ; Sobrescribe los registros con datos nuevos
    mov ebx, 666
    call DumpRegs               ; Verifica la modificacion temporal en pantalla

    pop ebx                     ; Restaura EBX primero por ser el ultimo guardado
    pop eax                     ; Restaura EAX al final
    nop
    call DumpRegs               ; Verifica que los valores originales regresaron

    ; Cuarto escenario para invocar subrutinas
    mov edx, OFFSET tBloque4
    call MostrarTitulo

    mov eax, 50
    mov ebx, 100

    call aumentarDiez           ; Ejecuta un procedimiento externo al bloque principal
    nop
    call DumpRegs               ; Observa el resultado tras retornar

    exit
main ENDP

MostrarTitulo PROC
    ; Subrutina auxiliar para imprimir saltos de linea y rotulos
    call Crlf
    call WriteString
    call Crlf
    ret                         ; Retorna el control de flujo al bloque principal
MostrarTitulo ENDP

aumentarDiez PROC
    ; Subrutina que incrementa un valor protegiendo los registros ajenos
    push ebx                    ; Salva el contenido original de EBX

    mov ebx, 10
    add eax, ebx                ; Suma diez unidades al registro de operaciones

    pop ebx                     ; Devuelve el valor original a EBX antes de finalizar

    ret                         ; Termina la subrutina
aumentarDiez ENDP

END main