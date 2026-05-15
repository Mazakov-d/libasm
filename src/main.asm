extern ft_strlen
extern ft_strcpy
extern ft_write

section .data
    msg: db "Salut la vie c'est cool d'etre ici", 0

    test: db "style tu pues du cul", 0

section .text
    global _start

_start:
    mov rdi, msg
    mov rsi, test
    call ft_strcpy

    mov rdi, msg
    call ft_write

    mov rdi, 0
    mov rax, 60
    syscall