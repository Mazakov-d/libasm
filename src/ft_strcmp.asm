section .text
	global ft_strcmp

	ft_strcmp:
		xor rcx, rcx
		jmp .loop
		ret

	.loop:
		movsx rax, byte [rdi + rcx]
		movsx rdx, byte [rsi + rcx]
		sub rax, rdx
		cmp dl, 0
		je .done
		cmp rax, 0
		jnz .done
		inc rcx
		jmp .loop

	.done:
		ret

section .note.GNU-stack noalloc noexec nowrite progbits