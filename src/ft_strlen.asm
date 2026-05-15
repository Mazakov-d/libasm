section .text
	global ft_strlen

	ft_strlen:
		xor rcx, rcx


		.loop:
			mov al, [rdi]

			cmp al, 0
			je .done

			inc rdi
			inc rcx
			jmp .loop
		
		.done:
			mov rax, rcx
			ret