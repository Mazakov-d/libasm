extern __errno_location

section .text

	global ft_read

	ft_read:
		push rbp
		mov rbp, rsp
		mov rax, 0
		syscall

		test rax, rax
		js .error
		pop rbp
		ret

	.error:
		neg rax
		mov rbx, rax
		call __errno_location
		mov dword [rax], ebx
		mov rax, -1
		pop rbp
		ret

section .note.GNU-stack noalloc noexec nowrite progbits