extern ft_strlen

default rel

section .rodata
    c: db "test", 0
    len equ $ - c

section .text
global ft_write

ft_write:
		call ft_strlen

		mov rsi, rdi
		mov rdi, 1
		mov rdx, rax
		mov rax, 1
		syscall
		ret