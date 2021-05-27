STACK SEGMENT STACK
   DB 64 DUP(?)
STACK ENDS
;----------------Escribe una palabra y el programa identificará cuantas vocales han sido ingresadas -------------------------------------
DATA SEGMENT
cadena db '          $'
ENTER DB 13,10, '$' 
contador db 0
txt1 db '  Suma de vocales: $'
txt2 db ' Suma de vocaless: 10 $'
DATA ENDS
;-----------------------------------------------------
CODE SEGMENT
Assume DS:DATA, CS:CODE, SS:STACK
BEGIN:mov ax,data
       mov ds,ax
	 ;-----------------------------------
       mov ah,00h  ;modo 80x25 a color
       mov al,03h
       int 10h
	;------ MODO DE PANTALLA-------------
	
       mov cx,10   ; el contador vale 10 para tener 10 caracteres
       mov si,0  ;puntero de pila en 0   
leer:  mov ah,07h ; esperar recibir un caracter y lo coloca en al
       int 21h 	   
	  
	   mov dl,al  ; se mueve a dl porque el 02 exhibe el caracter en dl
       mov ah,02h
       int 21h
       mov cadena[si],al
       inc si	   
       loop leer ; decrementa el contador     hasta que el contador sea 0 se detiene	   
	;--------------va a llenar el "arreglo"--------------------------------------	 
	
	   mov cx,8
	   mov si,0
compara:cmp cadena[si], 97   ;-------la a -----------;
        JE CONTAR
	    cmp cadena[si], 65  ;-------la A -----------;
        JE CONTAR
        cmp cadena[si],101 ;-----------e-------------
		JE CONTAR
		cmp cadena[si],69    ; la E
		JE CONTAR
		cmp cadena [si],105;-------i----
		JE CONTAR
		cmp cadena [si], 73 ; LA I
		JE CONTAR
		cmp cadena[si],111;-----o-------
		JE CONTAR
		cmp cadena [si], 79 ; la O
		JE CONTAR
		cmp cadena[si],117;-----u-------
		JE CONTAR
		cmp cadena [si],85 ; la u
		JE CONTAR	   
		inc si
		loop compara
	 ;--------Validar Vocales-----------------------------------
	
	 
	 lea dx,ENTER
	 mov ah, 09h         
	 int 21h
	
	mov ah,2
    mov dl,contador     
	add dl, 48
	;para mostrar el 10
	mov al, dl
	cmp al,58
	je DIEZ
	int 21h
	
	lea dx,txt1
	 mov ah, 09h        
	 int 21h
	
FIN: MOV AX,4C00H
     INT 21H
     RET	 


;-------------- ETIQUETAS--------------------------------	 
CONTAR:
    inc contador
	inc si
    JMP compara
DIEZ:
     lea dx,txt2
	 mov ah, 09h         
	 int 21h
	 jmp FIN
	
CODE ENDS
     END BEGIN