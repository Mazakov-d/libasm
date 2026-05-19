extern __errno_location
extern malloc
extern ft_strlen
extern ft_strcpy

section .text

	global ft_strdup

	ft_strdup:
		push rbp
		mov rbp, rsp
		push rbx
		push r12

		mov r12, rdi
		call ft_strlen

		mov rdi, rax
		add rdi, 1
		call malloc

		test rax, rax
		jz .error

		mov rbx, rax
		mov rdi, rax
		mov rsi, r12
		call ft_strcpy

		mov rax, rbx

		pop r12
		pop rbx
		pop rbp

		ret

	.error:
		call __errno_location
		mov  dword [rax], 12
		xor  rax, rax
		pop  r12
		pop  rbx
		pop  rbp
		ret

section .note.GNU-stack noalloc noexec nowrite progbits