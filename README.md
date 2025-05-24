===========================================
 PROYECTO: Operaciones aritméticas en NASM
===========================================

Portada
-----
Brayan Fernando Ramírez Salinas

Curso: Diseño y Estructura de Computadoras

Docente: Ing. Erick Vladimir Guirola Lemus

Fecha: 25/05/2025

DESCRIPCIÓN GENERAL
-------------------
Este proyecto consiste en tres programas escritos en lenguaje ensamblador NASM (para Linux, arquitectura de 32 bits). Cada uno realiza una operación aritmética básica: resta, multiplicación o división, y convierte el resultado a formato ASCII decimal para mostrarlo por pantalla.

El propósito general es comprender cómo funcionan las operaciones a bajo nivel y cómo convertir y mostrar datos sin el uso de funciones de alto nivel.

CONTENIDO DEL PROYECTO
-----------------------

1. **resta.asm**
   - **Propósito:** Restar tres números utilizando registros de 16 bits (AX, BX y CX) y mostrar el resultado.
   - **Operación:** 300 - 100 - 50 = 150
   - **Aprendizaje clave:** Uso de registros de 16 y 32 bits; conversión a ASCII; impresión en consola con `int 0x80`.

2. **multiplicacion.asm**
   - **Propósito:** Multiplicar dos números de 8 bits (AL * BL) y mostrar el resultado almacenado en AX.
   - **Operación:** 15 * 10 = 150
   - **Aprendizaje clave:** Uso de instrucción `MUL`; conversión del resultado a cadena ASCII decimal; uso de syscall `write`.

3. **division.asm**
   - **Propósito:** Dividir dos números enteros de 32 bits (EAX / EBX) y mostrar el cociente y el residuo.
   - **Operación:** 50 / 7 = 7 (residuo 1)
   - **Aprendizaje clave:** Manejo de `EDX:EAX` como dividendo; obtención del residuo; impresión separada del cociente y residuo.

REQUISITOS
----------
- NASM (Netwide Assembler)
- Linux (32 bits o con soporte para llamadas a 32 bits)

CÓMO COMPILAR Y EJECUTAR
-------------------------
Cada archivo se compila y ejecuta de la siguiente forma:

### Compilación

Ejemplo:
---------------------
```bash
nasm -f elf32 archivo.asm -o archivo.o
ld -m elf_i386 -s -o archivo archivo.o
