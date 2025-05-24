section .data
    msg db "Cociente: ", 0
    msg2 db "Residuo: ", 0
    newline db 0xA        ; Salto de línea
    resultado db 6 dup(0) ; espacio para 5 dígitos + null

section .text
    global _start

_start:
    ; --- Ingresar los números (puedes cambiarlos)
    mov eax, 50    ; Primer número (A = 50)
    mov ebx, 7     ; Segundo número (B = 7)

    ; Hacer la división: EAX / EBX
    ; Antes de hacer la división, debemos asegurarnos que EAX tenga el dividendo.
    ; Para divisiones grandes, necesitamos EDX:EAX como dividendo.
    ; Como no hay número grande, inicializamos EDX a 0 para que el dividendo sea solo EAX.

    xor edx, edx   ; Limpiamos EDX (sin valor)
    div ebx        ; División: EAX / EBX, cociente en EAX, residuo en EDX

    ; --- Imprimir el cociente
    ; Convertir el cociente a una cadena de caracteres ASCII
    mov ecx, eax   ; Copiamos el cociente (EAX) a ECX
    mov esi, resultado + 5  ; Apuntamos al final del buffer
    mov edi, 0              ; Contador de dígitos (inicializado a 0)

.convertir_cociente:
    xor edx, edx             ; Limpiamos EDX para la división
    mov ebx, 10              ; División entre 10
    div ebx                  ; EAX / 10 -> cociente en EAX, resto en EDX
    add dl, '0'              ; Convertimos el dígito a su valor ASCII
    dec esi
    mov [esi], dl
    inc edi
    test eax, eax
    jnz .convertir_cociente  ; Continuar mientras EAX no sea 0

    ; Imprimir el mensaje "Cociente: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 10             ; Longitud del mensaje
    int 0x80

    ; Imprimir el cociente
    mov eax, 4
    mov ebx, 1
    mov ecx, esi            ; Puntero al cociente convertido
    mov edx, edi            ; Número de dígitos
    int 0x80

    ; --- Imprimir el residuo
    ; Convertir el residuo (EDX) a cadena ASCII
    mov ecx, edx            ; Copiar el residuo (EDX) a ECX
    mov esi, resultado + 5  ; Apuntamos al final del buffer
    mov edi, 0              ; Contador de dígitos para el residuo

.convertir_residuo:
    xor edx, edx             ; Limpiamos EDX para la división
    mov ebx, 10              ; División entre 10
    div ebx                  ; EAX / 10 -> cociente en EAX, resto en EDX
    add dl, '0'              ; Convertimos el dígito a su valor ASCII
    dec esi
    mov [esi], dl
    inc edi
    test eax, eax
    jnz .convertir_residuo   ; Continuar mientras EAX no sea 0

    ; Imprimir el mensaje "Residuo: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 10             ; Longitud del mensaje
    int 0x80

    ; Imprimir el residuo
    mov eax, 4
    mov ebx, 1
    mov ecx, esi            ; Puntero al residuo convertido
    mov edx, edi            ; Número de dígitos
    int 0x80

    ; Imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
