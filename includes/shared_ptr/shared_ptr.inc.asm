%ifndef __SHARED_PTR_INC_FILE__
%define __SHARED_PTR_INC_FILE__



%ifndef __SHARED_PTR_CLASS__

extern class@Shared_ptr#constructor@size
extern class@Shared_ptr#copy_constructor@Shared_ptr
extern class@Shared_ptr#method@delete

%else

%include "includes/Clib.inc.asm"
%include "includes/class.inc.asm"

%endif

%define class_Shared_ptr_id 0x0C_C5_A1_A3
%define class_Shared_ptr_sizeof 16

%define class_Shared_ptr_method_get_ptr 0x39BBEAD2

;stack :
;	class index : this+0
;	ptr : 8 	:this+8
;	total : 16 octets
;
;heap :
;	address : 8							0
;	counter : 4							8
;	flag 	: 4, call_delete(0b1)		12


%endif