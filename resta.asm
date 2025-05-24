section .data
    msg db "Resultado: ", 0
    resultado db 6 dup(0)
    newline db 0xA


section .text
    global _start

_start:
    ; --- Parte de 16 bits: operar con AX, BX, CX
    mov ax, 300     ; A = 300
    mov bx, 100     ; B = 100
    mov cx, 50      ; C = 50

    sub ax, bx      ; AX = 300 - 100 = 200
    sub ax, cx      ; AX = 200 - 50 = 150

    ; Guardamos AX en un registro de 32 bits para conversión e impresión
    ; (llamadas al sistema requieren registros de 32 bits)
    movzx eax, ax   ; mover AX a EAX (extensión cero)
    
    ; Convertir número en EAX a cadena ASCII decimal
    mov esi, resultado + 5   ; apuntar al final de buffer
    mov ecx, 0               ; contador de dígitos

.to_ascii:
    xor edx, edx             ; limpiar EDX para división 32 bits
    mov ebx, 10
    div ebx                  ; EAX / 10 -> cociente en EAX, resto en EDX
    add dl, '0'              ; convierte dígito a ASCII
    dec esi
    mov [esi], dl
    inc ecx
    test eax, eax
    jnz .to_ascii

    ; Mostrar mensaje "Resultado: "
    mov eax, 4              ; syscall: sys_write
    mov ebx, 1              ; fd: stdout
    mov ecx, msg
    mov edx, 10             ; longitud del mensaje
    int 0x80

    ; Mostrar el número convertido
    mov eax, 4
    mov ebx, 1
    mov ecx, esi            ; puntero al número ASCII
    mov edx, resultado + 5
    sub edx, esi            ; longitud del número
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80


    ; Salir
    mov eax, 1
    xor ebx, ebx
    int 0x80
