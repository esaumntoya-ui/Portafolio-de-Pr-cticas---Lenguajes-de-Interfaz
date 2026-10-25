Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 6. Control de ocupación de un estacionamiento
; Descripción: Simulación del control de acceso a un estacionamiento mediante un menú.
; Se aplican las instrucciones INC y DEC para llevar el registro de vehículos,
; asegurando que no se supere el límite de cupo ni existan valores negativos.

INCLUDE Irvine32.inc

.data
    capacidad = 20                  ; Valor maximo permitido de vehiculos

    msgOp1      BYTE "1. Entra un carro",0
    msgOp2      BYTE "2. Sale un carro",0
    msgOp3      BYTE "3. Salir",0
    msgOpcion   BYTE "Opcion: ",0
    msgLleno    BYTE "ESTACIONAMIENTO LLENO: no se permite entrar mas carros.",0
    msgVacio    BYTE "ESTACIONAMIENTO VACIO.",0
    msgCarros   BYTE "Carros dentro: ",0

.code
main PROC
    mov ebx, 0                  ; Registro EBX inicia limpio para contar los vehiculos

menu:                           ; Etiqueta para imprimir la interfaz de usuario
    call Crlf
    mov edx, OFFSET msgOp1
    call WriteString
    call Crlf
    mov edx, OFFSET msgOp2
    call WriteString
    call Crlf
    mov edx, OFFSET msgOp3
    call WriteString
    call Crlf
    mov edx, OFFSET msgOpcion
    call WriteString
    call ReadInt                ; Se lee el numero digitado y se guarda en EAX

    ; Verificacion de la eleccion del usuario
    cmp eax, 1                  
    je entrada                  ; Brinca a la etiqueta entrada si se tecleo 1
    cmp eax, 2
    je salida                   ; Brinca a la etiqueta salida si se tecleo 2
    cmp eax, 3
    je fin                      ; Termina la ejecucion si se tecleo 3
    jmp menu                    ; Retorna al inicio si se escribio una opcion no valida

entrada:                        ; Proceso de acceso de un automovil
    cmp ebx, capacidad
    jae lleno                   ; Verifica si ya se llego al tope de capacidad
    inc ebx                     ; Suma uno al total de autos almacenados
    cmp ebx, capacidad
    jne mostrar                 ; Pasa directo a imprimir si todavia quedan lugares libres
lleno:
    mov edx, OFFSET msgLleno    ; Notifica en consola que ya no caben mas autos
    call WriteString
    call Crlf
    jmp mostrar

salida:                         ; Proceso de egreso de un automovil
    cmp ebx, 0
    je vacio                    ; Revisa si el estacionamiento ya se encuentra sin autos
    dec ebx                     ; Resta uno al inventario de vehiculos
    jnz mostrar                 ; Si quedan mas carros, salta a la impresion
vacio:
    mov edx, OFFSET msgVacio    ; Notifica que no hay vehiculos disponibles para retirar
    call WriteString
    call Crlf

mostrar:                        ; Despliega el estatus actual de ocupacion en pantalla
    mov edx, OFFSET msgCarros
    call WriteString
    mov eax, ebx                ; Prepara EAX con el valor de EBX para usar WriteDec
    call WriteDec
    call Crlf
    jmp menu                    ; Regresa a las opciones principales para el proximo turno

fin:
    exit
main ENDP
END main
