; Materia: Lenguajes de Interfaz 
; Alumno: Esau Beltran Montoya
; Horario: 10 a 11
; Docente: Dr. José Luis Medina Jiménez 
; Práctica: 15. Manipulación de archivos
; Descripción: Demuestra la creacion escritura y cierre de un archivo de texto
; utilizando las rutinas del sistema operativo. Incluye validaciones
; para manejar posibles errores durante el proceso de guardado.

INCLUDE Irvine32.inc

.data
    nombreArchivo BYTE "practica15.txt",0
    texto BYTE "Practica 15: crear y guardar un archivo de texto.",0Dh,0Ah,0
    archivoHandle DWORD ?
    mensajeExito BYTE "Archivo guardado correctamente.",0
    mensajeError BYTE "No se pudo guardar el archivo",0

.code
main PROC
    ; Genera un nuevo archivo de texto en el directorio del programa
    mov edx, OFFSET nombreArchivo
    call CreateOutputFile

    ; Valida si el sistema operativo otorgo los permisos correctamente
    cmp eax, INVALID_HANDLE_VALUE
    je error

    ; Respalda el identificador unico del archivo abierto
    mov archivoHandle, eax

    ; Prepara los parametros para vaciar la cadena de texto en el disco
    mov eax, archivoHandle
    mov edx, OFFSET texto
    mov ecx, SIZEOF texto - 1       ; Excluye el caracter nulo terminador
    call WriteToFile

    ; Comprueba que la cantidad de bytes guardados coincida con el total esperado
    cmp eax, SIZEOF texto - 1
    jne errorEscritura

    ; Libera el documento para que pueda ser utilizado por otros programas
    mov eax, archivoHandle
    call CloseFile

    ; Confirma que la operacion de cierre concluyo exitosamente
    test eax, eax
    jz error

    ; Notifica al usuario que el proceso finalizo sin problemas
    mov edx, OFFSET mensajeExito
    call WriteString
    call Crlf
    jmp fin

errorEscritura:
    ; Fuerza el cierre del archivo incluso si fallo la transferencia de datos
    mov eax, archivoHandle
    call CloseFile

error:
    ; Despliega la notificacion de falla general
    mov edx, OFFSET mensajeError
    call WriteString
    call Crlf

fin:
    exit

main ENDP

END main