%ifndef __LIST_INC_FILE__
%define __LIST_INC_FILE__



%ifndef __LIST_CLASS__

extern class@List#constructor@defaut

%else


%endif

%define class_List_id 0x376648EB
%define class_List_sizeof 64

;class index 	: 8 octets 	: this+0 	
;first node 	: 8 octets 	: this+8
;last node 		: 8 octets 	: this+16
;size 			: 8 octets 	: this+24

;total : 64 octets
%endif