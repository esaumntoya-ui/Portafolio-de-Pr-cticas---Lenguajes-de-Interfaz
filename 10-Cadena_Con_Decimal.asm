; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: Extra (Cálculo de progreso de descarga)
; Descripción: Realiza calculos matematicos para simular el progreso de una
; transferencia de datos. Determina los bytes descargados los pendientes 
; el porcentaje de avance y la agrupacion de informacion en bloques.

INCLUDE Irvine32.inc

.data
    tamanoArchivo DWORD 100000          ; Capacidad total del archivo a descargar
    bloquesRecibidos DWORD 125          ; Cantidad de piezas de informacion transferidas
    tamanoBloque DWORD 512              ; Peso en bytes asignado a cada pieza

    bytesDescargados DWORD 0            ; Variable para alojar el total transferido
    bytesPendientes DWORD 0             ; Variable para alojar el resto de la descarga
    porcentajeAvance DWORD 0            ; Variable para calcular el progreso total
    gruposCompletos DWORD 0             ; Cantidad de bloques completos de un kilobyte
    residuoGrupos DWORD 0               ; Datos sueltos que no alcanzan a formar un kilobyte

    buffer BYTE 11 DUP(0)               ; Espacio reservado para armar la cadena de texto

    msgDescargados BYTE "Bytes descargados: ",0 
    msgPendientes BYTE "Bytes pendientes: ",0 
    msgPorcentaje BYTE "Porcentaje de avance: ",0 
    msgGrupos BYTE "Grupos completos de 1024 bytes: ",0 
    msgResiduo BYTE "Residuo del agrupamiento: ",0 

.code
main PROC
    ; Proceso para calcular el total de informacion ya transferida
    mov eax, bloquesRecibidos           ; Carga la cantidad de piezas obtenidas
    mul tamanoBloque                    ; Multiplica las piezas por su peso individual
    mov bytesDescargados, eax           ; Respalda el resultado en la variable de memoria

    ; Proceso para calcular la informacion que falta por descargar
    mov ebx, tamanoArchivo              ; Carga el peso total del archivo original
    sub ebx, eax                        ; Resta los datos que ya fueron transferidos
    mov bytesPendientes, ebx            ; Respalda la diferencia calculada en memoria

    ; Proceso para determinar el avance porcentual de la descarga
    mov eax, bytesDescargados           ; Recupera los datos obtenidos
    mov ebx, 100                        ; Prepara el multiplicador para obtener el porcentaje
    mul ebx                             ; Escala el valor para la division
    div tamanoArchivo                   ; Divide el total escalado entre el tamano original
    mov porcentajeAvance, eax           ; Respalda el porcentaje calculado

    ; Proceso para agrupar los datos transferidos en kilobytes enteros
    mov eax, bytesDescargados           ; Carga la informacion transferida nuevamente
    mov edx, 0                          ; Vacia la parte alta del registro para la division
    mov ebx, 1024                       ; Establece la equivalencia de un kilobyte en bytes
    div ebx                             ; Ejecuta la division para separar enteros y sobrantes
    mov gruposCompletos, eax            ; Asigna el cociente a los grupos enteros
    mov residuoGrupos, edx              ; Asigna el residuo a los datos sueltos

    ; Bloque de impresion para desplegar todos los resultados
    mov eax, bytesDescargados           
    mov edx, OFFSET msgDescargados      
    call mostrarNumero                  ; Llama a la rutina para imprimir titulo y cantidad

    mov eax, bytesPendientes            
    mov edx, OFFSET msgPendientes       
    call mostrarNumero                  

    mov eax, porcentajeAvance           
    mov edx, OFFSET msgPorcentaje       
    call mostrarNumero                  

    mov eax, gruposCompletos            
    mov edx, OFFSET msgGrupos           
    call mostrarNumero                  

    mov eax, residuoGrupos              
    mov edx, OFFSET msgResiduo          
    call mostrarNumero                  

    exit                                ; Concluye las operaciones principales
main ENDP

mostrarNumero PROC
    ; Subrutina que imprime un texto acompanado de su valor numerico convertido
    push eax                            ; Protege el valor numerico original
    call WriteString                    ; Imprime la etiqueta descriptiva en consola
    pop eax                             ; Recupera el valor para poder procesarlo

    mov esi, OFFSET buffer              ; Carga la direccion de memoria para depositar el texto
    call convertirDecimal               ; Ejecuta la transformacion de numero a caracteres

    mov edx, OFFSET buffer              
    call WriteString                    ; Muestra la cadena numerica recien creada
    call Crlf                           ; Inserta un salto de linea para separar bloques
    ret                                 ; Devuelve el control a la funcion principal
mostrarNumero ENDP

convertirDecimal PROC
    ; Subrutina para desglosar un registro numerico en caracteres ascii
    push eax                            ; Respalda los registros utilizados
    push ebx                            
    push ecx                            
    push edx                            
    push esi                            

    mov ebx, 10                         ; Establece el divisor para sistema decimal
    mov ecx, 0                          ; Reinicia el contador de extracciones

extraerDigitos:
    mov edx, 0                          ; Asegura que la parte alta este vacia antes de dividir
    div ebx                             ; Fracciona el numero apartando el ultimo digito
    push edx                            ; Respalda el residuo en la pila del sistema
    inc ecx                             ; Aumenta el registro de digitos procesados
    cmp eax, 0                          ; Evalua si el registro principal ya quedo vacio
    jne extraerDigitos                  ; Retorna a dividir si aun quedan numeros

construirCadena:
    pop edx                             ; Recupera el ultimo digito extraido en orden inverso
    add dl, '0'                         ; Suma el valor necesario para obtener el caracter ascii
    mov [esi], dl                       ; Deposita el caracter en el arreglo de memoria
    inc esi                             ; Mueve el puntero hacia la siguiente casilla
    loop construirCadena                ; Repite el proceso hasta vaciar el contador ECX

    mov BYTE PTR [esi], 0               ; Inserta el caracter nulo para terminar la cadena de texto

    pop esi                             ; Restaura todos los registros a su estado original
    pop edx                             
    pop ecx                             
    pop ebx                             
    pop eax                             
    ret                                 ; Finaliza el procesamiento de conversion
convertirDecimal ENDP

END main