%ifndef __LIST_NODE_INC_FILE__
%define __LIST_NODE_INC_FILE__



%ifndef __LIST_NODE_CLASS__

extern class@List_Node#constructor@size

%else

%include "includes/Clib.inc.asm"
%include "includes/class.inc.asm"

%endif

%include "includes/shared_ptr/shared_ptr.inc.asm"

%define class_List_Node_id 0x824C5BE8
%define class_List_Node_sizeof 32

%define class_List_Node_method_get_prev 0xC9F88C76
%define class_List_Node_method_get_next 0x7135141F
%define class_List_Node_method_set_prev 0x3B46C39E
%define class_List_Node_method_set_next 0x97D16CC9
%define class_List_Node_method_remove 0x924E7AF0

;extends shared_ptr	: 16 octets 	: this+0 	
;prev_node 			: 8 octets 		: this+16
;next_node 			: 8 octets 		: this+24

;total : 32 octets
%endif