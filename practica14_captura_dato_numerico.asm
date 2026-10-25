; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 14. Captura y almacenamiento de datos numéricos
; Descripción: Rutina que captura caracteres numericos desde el teclado
; para transformarlos en un valor real manejable por el procesador.
; Incluye validacion de formato y almacenamiento del dato en la memoria RAM.

INCLUDE Irvine32.inc

.data
    mensaje BYTE "Cantidad de tarjetas ESP32 recibidas (1 a 99): ",0
    errorMsg BYTE "Cantidad invalida. Intente nuevamente.",0
    resultado BYTE "Existencia actual: ",0
    unidades BYTE " unidades",0

    entrada BYTE 10 DUP(0)
    bufferNumero BYTE 11 DUP(0)
    temporal BYTE 10 DUP(0)

    cantidadRecibida DWORD 0
    existenciaInicial DWORD 25
    existenciaActual DWORD 0
    longitud DWORD 0

.code
main PROC

leerCantidad:
    ; Pide al usuario que teclee la cantidad entrante
    mov edx, OFFSET mensaje
    call WriteString

    ; Captura la cadena de caracteres introducida por teclado
    mov edx, OFFSET entrada
    mov ecx, SIZEOF entrada - 1
    call ReadString

    ; Guarda el numero total de caracteres escritos
    mov longitud, eax

    ; Evalua que la captura contenga solamente uno o dos caracteres
    cmp eax, 1
    jl cantidadInvalida
    cmp eax, 2
    jg cantidadInvalida

    ; Configura el ciclo para analizar cada caracter individualmente
    mov esi, OFFSET entrada
    mov ecx, longitud

validarDigitos:
    ; Verifica que el valor ascii corresponda a un numero valido
    mov al, [esi]
    cmp al, '0'
    jb cantidadInvalida
    cmp al, '9'
    ja cantidadInvalida

    inc esi
    loop validarDigitos

    ; Transforma el valor ascii de la primera posicion a un entero real
    mov esi, OFFSET entrada
    movzx eax, BYTE PTR [esi]
    sub eax, '0'

    ; Omite la conversion del segundo digito si la entrada fue de un solo numero
    cmp longitud, 1
    je validarRango

    ; Procesa la segunda posicion sumandola a la primera multiplicada por diez
    imul eax, 10
    movzx ebx, BYTE PTR [esi+1]
    sub ebx, '0'
    add eax, ebx

validarRango:
    ; Revisa que la cifra calculada no exceda el limite de noventa y nueve
    cmp eax, 1
    jl cantidadInvalida
    cmp eax, 99
    jg cantidadInvalida

    ; Almacena el valor numerico final en la variable destinada en memoria
    mov cantidadRecibida, eax

    ; Recupera el inventario original para sumarle la nueva entrada
    mov eax, existenciaInicial
    add eax, cantidadRecibida
    
    ; Guarda el total actualizado en la memoria RAM
    mov existenciaActual, eax

    ; Despliega el rotulo de respuesta en consola
    mov edx, OFFSET resultado
    call WriteString

    ; Manda llamar al procedimiento de transformacion a texto
    mov eax, existenciaActual
    call ConvertirDecimal

    ; Imprime la cifra convertida
    mov edx, OFFSET bufferNumero
    call WriteString

    ; Añade la descripcion de las piezas al final del texto
    mov edx, OFFSET unidades
    call WriteString
    call Crlf

    exit

cantidadInvalida:
    ; Muestra un aviso de error y reinicia la captura de informacion
    mov edx, OFFSET errorMsg
    call WriteString
    call Crlf
    jmp leerCantidad

main ENDP

ConvertirDecimal PROC
    ; Procedimiento para convertir el valor entero de EAX a cadena de texto
    ; Respalda los registros que seran utilizados
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    mov ebx, 10
    mov esi, OFFSET temporal
    xor ecx, ecx                ; Reinicia el contador de divisiones

    ; Revisa si el valor numerico es cero absoluto
    cmp eax, 0
    jne dividirNumero

    ; Asigna un cero ascii directo si la variable no tenia valor
    mov BYTE PTR [esi], '0'
    inc esi
    inc ecx
    jmp copiarNumero

dividirNumero:
    ; Ejecuta divisiones consecutivas para aislar cada digito
    xor edx, edx
    div ebx

    ; Suma el valor ascii base para obtener el caracter imprimible
    add dl, '0'
    mov [esi], dl
    inc esi
    inc ecx

    ; Continua dividiendo hasta vaciar el registro
    cmp eax, 0
    jne dividirNumero

copiarNumero:
    ; Ajusta los indices para vaciar los digitos en el orden correcto
    dec esi
    mov edi, OFFSET bufferNumero

copiarDigito:
    ; Pasa los caracteres calculados a la variable final
    mov al, [esi]
    mov [edi], al
    inc edi
    dec esi
    loop copiarDigito

    ; Coloca el terminador de cadena al final del arreglo
    mov BYTE PTR [edi], 0

    ; Devuelve los registros a su estado anterior a la llamada
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax

    ret
ConvertirDecimal ENDP

END main