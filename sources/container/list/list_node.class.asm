%ifndef __LIST_NODE_CLASS__
%define __LIST_NODE_CLASS__

global class@List_Node#constructor@size


;-------------constructor----------------------

class@List_Node#constructor@size:
	push rbp
	mov rbp, rsp
	
	sub rbp, 32
	
	mov [rbp+8], rcx
	mov [rbp+16], rdx
	
	call class@Shared_ptr#constructor@size
	
	mov rcx, [rbp+8]
	mov rax, class@List_Node#controller@class
	mov [rcx], rax
	
	xor rax, rax
	
	mov [rcx+16], rax
	mov [rcx+24], rax
	
	mov rsp, rbp
	pop rbp
	ret
	
;------------controller-----------------------------

class@List_Node#controller@class:
	cmp r10, class_Ptr_id
	jz class@Shared_ptr#controller@method
	cmp r10, class_Shared_ptr_id
	jz class@Shared_ptr#controller@method
	cmp r10, class_List_Node_id
	jz class@List_Node#controller@method
	ret

class@Shared_ptr#controller@method:
	jmp class@Shared_ptr#controller@class
	ret

class@List_Node#controller@method:
	cmp r11, class_List_Node_method_get_prev
	jz class@List_Node#method@get_prev
	cmp r11, class_List_Node_method_get_next
	jz class@List_Node#method@get_next
	cmp r11, class_List_Node_method_set_prev
	jz class@List_Node#method@set_prev
	cmp r11, class_List_Node_method_set_next
	jz class@List_Node#method@set_next
	cmp r11, class_List_Node_method_remove
	jz class@List_Node#method@remove
	ret

;-----------------class@List_Node-------------------------

class@List_Node#method@get_prev:
	mov rax, [rcx+16]
	ret

class@List_Node#method@get_next:
	mov rax, [rcx+24]
	ret
	
class@List_Node#method@set_prev:
	mov [rcx+16], rdx
	cmp rdx, 0
	jz .L1
	
	mov [rdx+24], rcx
	
.L1:	
	ret
	
class@List_Node#method@set_next:
	mov [rcx+24], rdx
	cmp rdx, 0
	jz .L2
	
	mov [rdx+16], rcx
	
.L2:	
	ret
	
class@List_Node#method@remove:
	mov rdx, [rcx+16]
	mov r8, [rcx+24]
	cmp rdx, 0
	jz .L3
	mov [rdx+24], r8
.L3:
	cmp r8, 0
	jz .L4
	mov [r8+16], rdx
.L4:
	ret
	
%endif