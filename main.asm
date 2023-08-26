global main

%include "includes/Clib.inc.asm"
%include "includes/class.inc.asm"
%include "includes/shared_ptr/shared_ptr.inc.asm"
%include "includes/ptr/ptr.inc.asm"

section .text

%define ptr_1 rbp-class_Shared_ptr_sizeof
%define ptr_2 rbp-2*class_Shared_ptr_sizeof

main :
	push rbp
	mov rbp, rsp
	sub rsp, 64
	
	mov rdx, class_Shared_ptr_sizeof
	lea rcx, [ptr_1]
	call class@Shared_ptr#constructor@size
	
	lea rcx, [ptr_1]
	exec class_Ptr_id, class_Ptr_method_get_ptr
	
	mov rcx, rax 
	mov rdx, 8
	call class@Shared_ptr#constructor@size
	
	lea rcx, [ptr_1]
	exec 0, 3
	
	lea rdx, [ptr_1]
	lea rcx, [ptr_2]
	call class@Shared_ptr#copy_constructor@Shared_ptr
	
	lea rcx, [ptr_1]
	exec 0, 3

	lea rcx, [ptr_2]
	exec 0, 3
	
	lea rcx, [ptr_1]
	exec 0, 1
	
	lea rcx, [ptr_2]
	exec 0, 3
	
	mov rcx, msg
	call printf
	
	
	lea rcx, [ptr_2]
	exec 0, 1
	
	mov rcx, msg
	call printf
	
	mov rsp, rbp
	pop rbp
	xor rax, rax
	ret
	
%undef ptr_1
%undef ptr_2
	
section .data

msg : db "hello", 10, 0