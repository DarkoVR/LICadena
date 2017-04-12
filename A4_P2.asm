
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h  

;Programa creado por        
;RODRIGUEZ PEREZ LAURA JANNET
;MARCO ANTONIO VAZQUEZ RUELAS
;para la materia de Lenguajes de interfaz
;Lectura de cadena maximo 255 caracteres
;encuentra la cantidad de numeros en esta

.model small     ;Se define tamanio de memoria
.stack           ; Segmento de pila 128k definido por default
.data            ;Definicion del segmento de datos
    msg  db 'Numeros encontrados en la cadena: $'  ;Reserva de memoria para el mensaje definido con la etiqueta msg                
    infomsg db 'Programa que indica cuantos numeros se ingresaron',10,13,'$' ;Reserva de memoria para el mensaje definido con la etiqueta infomsg
    infomsg1 db 'Ingresa maximo 255 caracteres, termina de ingresar con "ENTER"',10,13,'$' ;Reserva de memoria para el mensaje definido con la etiqueta infomsg1
    maxCar db 'Numero de caracteres maximos alcanzados!!!',10,13,'$' ;Reserva de memoria para el mensaje definido con la etiqueta maxCar
    saltoLin db '',10,13,"$"  ;Reserva de memoria para el mensaje definido con la etiqueta saltoLin
    cen  db 0
    dece db 0
    uni  db 0 
.code                                              
    mov ax, @DATA
    mov ds, ax 
    
    mov cl,0 
    mov bl,0      
    
    mov ah,09h   ;Mensaje de bienvenida                    
    lea dx,infomsg   
    int 21h
    
    mov ah,09h   ;Mensaje instrucciones                    
    lea dx,infomsg1   
    int 21h
    
    mov ah,09h   ;Salto de linea vacio                    
    lea dx,saltoLin   
    int 21h
    
    inicio:
        mov ah, 01h
        int 21h 
        inc bl
        cmp al,0Dh
        je fin
        
        cmp al,30h
        jb inicio
        cmp al,39h
        ja inicio 
        inc cl  
        
        cmp bl,255
        je fin2 
        jmp valido
    
    
        valido:       
            mov ah, 01h
            int 21h  
            inc bl
            cmp al,0Dh
            je fin
            cmp bl,255
            je fin2 
        
            cmp al,30h
            jb inicio
            cmp al,39h
            ja inicio
            jmp valido
                
   
   fin2:   ;En caso de que se alcancen 255 caracteres
       mov ah,09h   ;salto de linea vacio                     
       lea dx,saltoLin
       int 21h 
       
       mov ah,09h   ;salto de linea vacio                     
       lea dx,saltoLin   
       int 21h
       
       mov ah,09h   ;mensaje del numero maximo (255) de caracteres alcanzado 
       lea dx,maxCar
       int 21h    
       
   fin: ;En caso de que no se llenen 255 caractres y se de enter  
       mov ah,09h   ;salto de linea vacio                     
       lea dx,saltoLin
       int 21h
       
       mov ah,09h   ;salto de linea vacio                     
       lea dx,saltoLin
       int 21h  
      
       mov ah,09h   ;mensaje del numero de caracteres
       lea dx,msg 
       int 21h      
       
    ajuste:
       
       mov al,cl    ;se asigna el contador cl a al para hacer ajuste
       aam          ;ajusta el valor en AL por: AH=cendece Y AL=uni
       
       mov uni,al   ;unidades se respalda en uni
       mov al,ah    ;se mueve ah a al para volver a separar
       aam          ;se separa lo que hay en AL por: AH=cen y AL=dece
       
       mov cen,ah   ;centenas se respalda en cen
       mov dece,al  ;decenas se respalda en dece
       
       ;se imprimen centenas,decenas y unidades
       
       mov ah,02h
       
       mov dl,cen   ;se imprimen centenas
       add dl,30h   
       int 21h
       
       mov dl,dece  ;se imprimen decenas
       add dl,30h
       int 21h
        
       mov dl,uni   ;se imprimen unidades
       add dl,30h
       int 21h
    
    salir:   
       mov ax,4ch   ;salir
       int 21h    
    
END



