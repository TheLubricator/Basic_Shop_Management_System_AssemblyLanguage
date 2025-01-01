.MODEL SMALL
DecimalPrinter macro var1 ;limit 2 hex bytes, 255 decimal
    mov al,var1
    mov ah,0
    mov bl,100
    div bl
    mov ch,ah
    mov cl,al
    mov dl,cl
    add dl,30h
    mov ah,2
    int 21h 
    mov ax,0
    mov al,ch
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

StockAdder macro var1
    mov bl, var1
    sub cl,30h
    add bl,cl
    mov var1,bl
    endm
 
.STACK 100H

.DATA   
LoginWelcomeMessage db "Welcome to Shop X! Please Login to continue.$"
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
success db "Success!$"
invalidnumber db "Please enter a valid number!$"
presskeytocontinue db "Press a key to continue: $"      
;main menu strings  
PressHashToMainMenu db "Press # to return to main menu: $"
SelectorHash db "Select Item or press # to return to main menu: $"
PressNumberToContinue db "Pick an option to continue: $"
main_menu_cash_register_msg db "Amount in cash_register: $" 
main_menu_viewstock db "1.) View Stock$"   
main_menu_AddStock db "2.) Add Stock$" 

; View stock page string
viewstockstr db "This page displays stock number for each item$" 


;AddStockPage
addstockstr db "Add stock from this page (greater than 0)$" 
enternumber db "Enter a valid number between 1-9: $"

;numerical data
cash_register db 56 
item_1_stock db 1  
item_2_stock db 2
item_3_stock db 3


;item names
item1_name db "Item 1: $"
item2_name db "Item 2: $"  
item3_name db "Item 3: $"



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

;;;;;;;;;;;;;;;;;;;;;;;;;Main menu start
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
call newlinecursorzero
mov ah,9
lea dx, main_menu_viewstock
int 21h  

call newlinecursorzero
mov ah,9
lea dx, main_menu_AddStock
int 21h 
 
 
call newlinecursorzero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Main menu option end
call hashloop  
mov ah,9
lea dx,PressNumberToContinue
int 21h

mov ah,1
int 21h

cmp al,31h
je ViewStockPage
cmp al,32h
je AddStockPage



jmp MainMenu
 
 
 
 ;;;;;;;;;;;;;;View stock Page
ViewStockPage:
call clearscr
call hashloop
call movepointertomiddle
mov ah,9
lea dx,viewstockstr 
int 21h
call newlinecursorzero
mov ah,9
lea dx,item1_name
int 21h
DecimalPrinter item_1_stock    

call newlinecursorzero
mov ah,9
lea dx,item2_name
int 21h
DecimalPrinter item_2_stock

call newlinecursorzero
mov ah,9
lea dx,item3_name
int 21h
DecimalPrinter item_3_stock

call newlinecursorzero
call hashloop
mov ah,9
lea dx, PressHashToMainMenu
int 21h

mov ah,1
int 21h

jmp MainMenu


 ;;;;;;;;;;;;;;Add Stock Page ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AddStockPage:
call clearscr
call hashloop
call movepointertomiddle
mov ah,9
lea dx, addstockstr 
int 21h
call newlinecursorzero
mov ah,9
lea dx,item1_name
int 21h 

call newlinecursorzero
mov ah,9
lea dx,item2_name
int 21h


call newlinecursorzero
mov ah,9
lea dx,item3_name
int 21h


call newlinecursorzero
call hashloop
mov ah,9
lea dx, SelectorHash
int 21h

mov ah,1
int 21h
cmp al, 31h
je AddItem1   

cmp al, 32h       ;;;;Sub menu redirection for 3 items
je AddItem2

cmp al, 33h
je AddItem3

cmp al, 23h
je MainMenu  

jmp AddStockPage ;any invalid input will refresh page

;;;;;;;;;
;add stock logic for item 1
AddItem1:  
call clearscr
call hashloop

mov ah,9
lea dx, enternumber
int 21h 

call newlinecursorzero
mov ah,1
int 21h
cmp al,30h
jle InputErrorAddStock1
cmp al,3Ah
jge InputErrorAddStock1 
mov cl,al 
call newlinecursorzero
mov ah,9
lea dx, success
int 21h 
 
call newlinecursorzero
mov ah,9
lea dx, presskeytocontinue
int 21h 

 
StockAdder item_1_stock
mov ah,1
int 21h
jmp AddStockPage   

InputErrorAddStock1:
call newlinecursorzero
mov ah,9
lea dx, invalidnumber
int 21h
call newlinecursorzero 
mov ah,9
lea dx, presskeytocontinue
int 21h  
mov ah,1
int 21h
jmp AddItem1 



;;;;;;;;;
;add stock logic for item 2
AddItem2:  
call clearscr
call hashloop

mov ah,9
lea dx, enternumber
int 21h 

call newlinecursorzero
mov ah,1
int 21h
cmp al,30h
jle InputErrorAddStock2
cmp al,3Ah
jge InputErrorAddStock2 
mov cl,al 
call newlinecursorzero
mov ah,9
lea dx, success
int 21h 
 
call newlinecursorzero
mov ah,9
lea dx, presskeytocontinue
int 21h 

 
StockAdder item_2_stock
mov ah,1
int 21h
jmp AddStockPage   

InputErrorAddStock2:
call newlinecursorzero
mov ah,9
lea dx, invalidnumber
int 21h
call newlinecursorzero 
mov ah,9
lea dx, presskeytocontinue
int 21h 
mov ah,1
int 21h
jmp AddItem2


;;;;;;;;;
;add stock logic for item 3
AddItem3:  
call clearscr
call hashloop

mov ah,9
lea dx, enternumber
int 21h 

call newlinecursorzero
mov ah,1
int 21h
cmp al,30h
jle InputErrorAddStock3
cmp al,3Ah
jge InputErrorAddStock3 
mov cl,al 
call newlinecursorzero
mov ah,9
lea dx, success
int 21h 
 
call newlinecursorzero
mov ah,9
lea dx, presskeytocontinue
int 21h 

 
StockAdder item_3_stock
mov ah,1
int 21h
jmp AddStockPage   

InputErrorAddStock3:
call newlinecursorzero
mov ah,9
lea dx, invalidnumber
int 21h
call newlinecursorzero 
mov ah,9
lea dx, presskeytocontinue
int 21h 
mov ah,1
int 21h
jmp AddItem3     

;;;;;;;;;;;;;;;;;;;;;;;;;;;END OF ADD STOCK;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









 









 

;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
