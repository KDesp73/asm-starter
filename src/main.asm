; main.asm

section .data
    hello db "Hello World", 10, 0  ; Null-terminated string
    hello_len equ $ - hello

section .text
    global main

main:
    ; Write "Hello World" to stdout
    mov eax, 4            ; syscall number for sys_write (0x4)
    mov ebx, 1            ; file descriptor 1 is stdout
    mov ecx, hello        ; pointer to the message
    mov edx, hello_len    ; message length
    int 0x80              ; interrupt to make the syscall

    ; Exit program
    mov eax, 1            ; syscall number for sys_exit (0x1)
    xor ebx, ebx          ; exit code 0
    int 0x80              ; interrupt to make the syscall
