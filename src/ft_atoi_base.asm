section .text
	global ft_atoi_base

	check_base:
		xor rax, rax
		.loop1:
			mov dl, [rsi + rax]

			cmp dl, 0
			je .done
			cmp dl, '-'
			je .base_error
			cmp dl, '+'
			je .base_error
			cmp dl, ' '
			je .base_error
			cmp dl, 9
			je .base_error
			cmp dl, 10
			je .base_error
			cmp dl, 11
			je .base_error
			cmp dl, 12
			je .base_error
			cmp dl, 13
			je .base_error

			mov rcx, rax
			add rcx, 1
			jmp .loop2

		.loop2:
			mov r10b, [rsi + rcx]
			cmp r10b, 0
			je .restarting_loop1
			cmp r10b, dl
			je .base_error
			inc rcx
			jmp .loop2

		.restarting_loop1:
			inc rax
			jmp .loop1

		.base_error:
			mov rax, 0
			ret

		.done:
			ret

	ft_atoi_base:
		call check_base
		cmp rax, 1
		jbe .error

		mov r8, rax
		mov rax, 0
		xor rcx, rcx
		.loop1:
			mov dl, [rdi + rcx]
			cmp dl, ' '
			je .increment_loop1
			cmp dl, 9
			je .increment_loop1
			cmp dl, 10
			je .increment_loop1
			cmp dl, 11
			je .increment_loop1
			cmp dl, 12
			je .increment_loop1
			cmp dl, 13
			je .increment_loop1

		mov r10, 1
		.loop2:
			mov dl, [rdi + rcx]
			cmp dl, '-'
			je .neg_sign
			cmp dl, '+'
			je .pos_sign

		.loop3:
			mov dl, [rdi + rcx]
			cmp dl, 0
			je .done

			xor r9, r9
			.loop4:
				mov r11b, [rsi + r9]
				cmp r11b, 0
				je .done
				cmp r11b, dl
				je .char_find
				inc r9
				jmp .loop4

			.char_find:
				imul rax, r8
				add rax, r9
				inc rcx
				jmp .loop3

	.neg_sign:
		cmp r10, -1
		je .set_positive
		jmp .set_negative

	.set_negative:
		mov r10, -1
		inc rcx
		jmp .loop2

	.set_positive:
		mov r10, 1
		inc rcx
		jmp .loop2

	.increment_loop1:
		inc rcx
		jmp .loop1

	.pos_sign:
		inc rcx
		jmp .loop2

	.done:
		imul rax, r10
		ret

	.error:
		mov rax, 0
		ret

section .note.GNU-stack noalloc noexec nowrite progbits