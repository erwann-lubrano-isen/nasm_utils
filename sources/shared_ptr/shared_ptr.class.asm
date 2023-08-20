%ifndef __SHARED_PTR_CLASS__
%define __SHARED_PTR_CLASS__

%include "includes/shared_ptr/shared_ptr.inc.asm"

global class@Shared_ptr#constructor@size
global class@Shared_ptr#copy_constructor@Shared_ptr
global class@Shared_ptr#method@delete

section .text

;-------------constructor-------------------


;param this rcx qword
;param size rdx qword
class@Shared_ptr#constructor@size:
	push rbp
	mov rbp, rsp
	
	sub rsp, 32
	
	mov [rbp+24], rcx
	mov [rbp+16], rdx
	
	mov rax, class@Shared_ptr#controller@class
	mov [rcx], rax
	
	;alloc data shared
	mov rcx, 16
	call malloc
	
	;this->ptr = rax
	mov rcx, [rbp+24]
	mov [rcx+8], rax
	
	;-----TODO-- checker le retour de malloc
	;cmp rax,0
	;---
	
	;this->ptr->count = 1
	mov QWORD[rax+8], 1
	
	mov rcx, [rbp+16]
	call malloc
	
	;-----TODO-- checker le retour de malloc
	;cmp rax,0
	;---
	
	;this->ptr->ptr = rax
	mov rcx, [rbp+24]
	mov rdx, [rcx+8]
	mov [rdx], rax
	
	mov rsp, rbp
	pop rbp
	ret

;param this rcx
;param shared_ptr rdx (address)
class@Shared_ptr#copy_constructor@Shared_ptr:
	push rbp
	mov rbp, rsp
	
	sub rsp, 32
	
	mov [rbp+24], rcx

	mov rax, class@Shared_ptr#controller@class
	mov QWORD[rcx], rax
	mov rcx, rdx
	exec class_Shared_ptr_id, 0
	mov [rbp+16], rcx
	
	;this->ptr = ptr->ptr
	mov rdx, [rcx+8]
	mov rcx, [rbp+24]
	mov [rcx+8],rdx
	
	;++this->ptr->count
	inc QWORD[rdx+8]
	
	mov rsp, rbp
	pop rbp
	ret

;-------------------controller--------------------

class@Shared_ptr#controller@class:
	cmp r10, class_Shared_ptr_id
	jz class@Shared_ptr#controller@method
	cmp r10, 0
	jz class@default#controller@method
	ret

class@default#controller@method:
	cmp r11, 1
	jz class@Shared_ptr#method@delete
	cmp r11, 2
	jz class@default#method@sizeof
	cmp r11, 3
	jz class@default#method@print
	ret

class@Shared_ptr#controller@method:
	cmp r11, class_Shared_ptr_method_get_ptr
	jz class@Shared_ptr#method@get_ptr
	ret
	
;---------------------class@default----------------------------
;param this : rcx 
class@Shared_ptr#method@delete:
	push rbp
	mov rbp, rsp
	
	sub rsp, 32
	
	mov [rbp+24], rcx
	
	mov rdx, [rcx+8]
	dec QWORD[rdx+8]
	;cmp QWORD[rdx+8], 0
	jnz .L1
	;---------------------
	mov [rbp+16], rdx
	exec 0, 3
	mov rdx, [rbp+16]
	;---------------------
	;delete this->ptr->ptr
	mov rcx, [rdx]
	exec 0, 1
	mov rcx, [rbp+24]
	mov rcx, [rcx+8]
	mov rcx, [rcx]
	call free
	;delete this->ptr
	mov rcx, [rbp+24]
	mov rcx, [rcx+8]
	call free
	
.L1:
	mov rsp, rbp
	pop rbp
	ret

class@default#method@sizeof:
	mov rax, class_Shared_ptr_sizeof
	ret
	
class@default#method@print:
	push rbp
	mov rbp, rsp
	
	sub rsp, 32
	
	mov [rbp+24], rcx
	mov rcx, [rcx+8]
	mov rdx, [rcx]
	mov r8, [rcx+8]
	mov rcx, str_print
	call printf
	mov rsp, rbp
	pop rbp
	ret


;-----------------------class@Shared_ptr----------------------

class@Shared_ptr#method@get_ptr:
	mov rax, [rcx+8]
	mov rax, [rax]
	ret

section .data

str_print : db "{ 'address' : %p, 'count' : %lu }", 10, 0
	
%endif