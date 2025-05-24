section .data
    msg db "Resultado: ", 0
    resultado db 6 dup(0) ; espacio para 5 dígitos + null
    newline db 0xA        ; salto de línea

section .bss
    ; No se necesita espacio extra aquí

section .text
    global _start

_start:
    ; --- Espacio para ingresar los numeros a multiplicar
    mov al, 15    ; Primer número (A = 15)
    mov bl, 10    ; Segundo número (B = 10)

    ; Multiplicar AL * BL -> Resultado en AX
    ; AX = AL * BL, pero solo tenemos AL y BL, el resultado va en AX
    ; AL = 8 bits, BL = 8 bits, AX = 16 bits
    mul bl        ; AX = AL * BL, resultado en AX (AL -> 8 bits, BL -> 8 bits)

    ; Guardar el resultado en un registro de 16 bits (AX) y convertirlo
    mov cx, ax    ; Guardamos el resultado en CX (porque AX tiene 16 bits)

    ; Convertir el número en CX a una cadena ASCII (decimal)
    mov esi, resultado + 5   ; Apuntar al final del buffer
    mov edi, 0               ; Inicializamos el contador de dígitos

.convertir:
    xor dx, dx              ; Limpiar DX para la operación de división
    mov bx, 10              ; División entre 10
    div bx                  ; AX / 10 -> cociente en AX, resto en DX
    add dl, '0'             ; Convertir el dígito a su valor ASCII
    dec esi
    mov [esi], dl
    inc edi
    test ax, ax
    jnz .convertir          ; Continuar si el cociente no es 0

    ; Mostrar el mensaje "Resultado: "
    mov eax, 4              ; syscall: sys_write
    mov ebx, 1              ; fd: stdout
    mov ecx, msg
    mov edx, 10             ; Longitud del mensaje
    int 0x80

    ; Mostrar el resultado
    mov eax, 4              ; sys_write
    mov ebx, 1              ; fd: stdout
    mov ecx, esi            ; Puntero al número convertido
    mov edx, edi            ; Número de dígitos
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
