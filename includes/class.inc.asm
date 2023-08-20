%ifndef __CLASS_INC_
%define __CLASS_INC_

;class default:
;method 0 : nop
;method 1 : delete
;methode 2 : sizeof
;method 3 : print

%macro exec 2
	mov r10, %1
	mov r11, %2
	call [rcx]
%endmacro

%endif