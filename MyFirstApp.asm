
;This app stores Strings in Memory, prints them out and does basic arithmetic.

format PE console
entry start

include 'win32a.inc' 

section '.bss' readable writeable

    output_handle   dd  ?
	

section 'data' data readable writeable
	
	bytes_written   dd  15   
    bytes_written2   dd  35
	
	; Messages to be printed
	a   db  'Hello, World!', 0x0D, 0x0A, 0  ;(0x0D - carriage return, 0x0A - line feed)
	b	db  'This program does basic arithmatic.',0
	
	
start:

	push    STD_OUTPUT_HANDLE		
    call    [GetStdHandle]					; Allows access to input and output
    mov     dword [output_handle],eax


	push    0                         		; Arguments needed for the WriteFile function
    push    bytes_written                   
    push    dword [bytes_written]           
    push    a                  		        
    push    dword [output_handle]           
	
    call    [WriteFile]                     ; Outputs the message to the console
	
	push    0                      		
    push    bytes_written2         	
    push    dword [bytes_written2] 		
    push    b                      		
    push    dword [output_handle]  	
	
    call    [WriteFile]					
	
	;Addition
	mov ax, 5		; 5 --> ax
	mov bx, 4		; 4 --> bx
	add ax, bx		; ax(5) + bx(4) --> ax(9)
	
	;Substraction
	mov bx, 9		; 9 --> bx
	sub ax, 9		; ax(9) - bx(9) --> ax(0)
	
	;Multiplication
	mov ax, 10		; 10 --> ax
	mov bx, 5		; 5 --> bx
	mul bx			; ax(10) * bx(5) --> dx:ax(50)
	
	;Division
	mov dx, 0		; clear dx register
	mov ax, 300		; 300 --> ax
	mov bx, 7		; 7 --> bx
	div bx   		; dx:ax(300) / bx(7) --> ax(42)  
					; dx:ax(300) % bx(7) --> dx(6)
					
					
	push	0
	call	[ExitProcess]		; End of program




section '.idata' import data readable			; imported files

library kernel32,'kernel32.dll'

import  kernel32,\
		GetStdHandle,'GetStdHandle',\
		ReadFile,'ReadFile',\
		WriteFile,'WriteFile',\
		ExitProcess,'ExitProcess'
