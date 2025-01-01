.MODEL SMALL
DecimalPrinter macro var1 ;limit 2 hex bytes
    mov al,var1
    mov ah,0
    mov bl,10
    div bl
    mov ch,ah
    mov cl,al
    mov dl,cl
    add dl,30h
    mov ah,2
    int 21h
    mov dl,ch
    add dl,30h
    mov ah,2
    int 21h 
    endm
 
.STACK 100H

.DATA  
spacer db " $"
dollarendermsg db " dollars$"
userid db 04Dh,61h,73h,74h,65h,06Dh,61h        
password db 35h,34h,33h,61h,62h,63h,64h
userIDinput db 7 dup(?)
IDinputmsg db "User ID: $"
passwordinput db 7 dup(?)
passinputmsg db "Password: $"
InvalidCredentials db "Invalid Credentials! Press any key to go back to login screen. $" 
welcome db "Welcome Mastema! These are your options$" 
main_menu_cash_register_msg db "Amount in cash_register: $"  
cash_register db 56
 
LoginWelcomeMessage db "Welcome to Shop X! Please Login to continue.$"
.CODE 
hashloop proc   ;produces 70 hash symbols then two spaces, decoration purpose
    mov cx,70
    hashloop1:
    mov dl, 23h
    mov ah,2 
    int 21h
    loop hashloop1 
    
    mov ah,2
    mov dl,0ah ;new line
    int 21h   
    mov ah,2
    mov dl,0dh ; carriage ret
    int 21h  
    mov ah,2
    mov dl,0ah ;new line
    int 21h   
    mov ah,2
    mov dl,0dh ; carriage ret
    int 21h
    ret
    hashloop endp 
movepointertomiddle proc     ; paired with hash, move pointer to middleish to print header msg, decoration PURPOSES
    mov cx,14
    pointerloop:
    mov ah,9
    lea dx,spacer ; carriage ret
    int 21h  
    loop pointerloop 
    
   
    ret
    movepointertomiddle endp    

clearscr proc
    
    MOV AX,0600H
    MOV BH,07
    MOV CX,0000
    MOV DX,184FH
    INT 10H
    
    MOV AH,2
    MOV BH,00
    MOV DL,00
    MOV DH,00
    INT 10H
    
    
     
    ret
    clearscr endp  
newlinecursorzero proc
    mov ah,2
    mov dl,0ah ;new line
    int 21h   
    mov ah,2
    mov dl,0dh ; carriage ret
    int 21h  
    ret
    newlinecursorzero endp

MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX
 
; enter your code here
 
bigbang:
call hashloop 
call movepointertomiddle 
mov ah, 9
lea dx, LoginWelcomeMessage 
int 21h 
mov ah,2
mov dl,0ah ;new line
int 21h   
mov ah,2
mov dl,0dh ; carriage ret
int 21h 


mov ah, 9
lea dx, IDinputmsg
int 21h
;start taking userid input
mov si,0

StartUserIDinput:
cmp si,7
jge EndUserIDinput
mov ah,1
int 21h
mov userIDinput[si],al
inc si
jmp StartUserIDinput

EndUserIDinput:
mov ah,2
mov dl,0ah ;new line
int 21h   
mov ah,2
mov dl,0dh ; carriage ret
int 21h


mov ah, 9
lea dx, passinputmsg
int 21h
;start taking userid input
mov si,0

StartPassinput:
cmp si,7
jge EndPassinput
mov ah,1
int 21h
mov passwordinput[si],al
inc si
jmp StartPassinput

EndPassinput:
mov ah,2
mov dl,0ah ;new line
int 21h   
mov ah,2
mov dl,0dh ; carriage ret
int 21h


  
mov si,0
AuthValidation:
cmp si,7
jge CorrectAuth
mov ch,userid[si]
mov cl,userIDinput[si]  
cmp ch,cl
jne InvalidAuth
mov ch,password[si]
mov cl,passwordinput[si]  
cmp ch,cl
jne InvalidAuth
inc si
jmp AuthValidation




InvalidAuth: 
mov ah,2
mov dl,0ah ;new line
int 21h   
mov ah,2
mov dl,0dh ; carriage ret
mov ah,9 
lea dx, InvalidCredentials 
int 21h 
mov ah,2
mov dl,0ah ;new line
int 21h   
mov ah,2
mov dl,0dh ; carriage ret
int 21h 
call hashloop
mov ah,1
int 21h 

call clearscr
jmp bigbang 

CorrectAuth: 


MainMenu:
call clearscr
call hashloop
call movepointertomiddle
mov ah,9 
lea dx,welcome  
int 21h
call newlinecursorzero 

mov ah,9
lea dx, main_menu_cash_register_msg
int 21h
DecimalPrinter cash_register 
mov ah,9
lea dx, dollarendermsg
int 21h 





 









 

;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
