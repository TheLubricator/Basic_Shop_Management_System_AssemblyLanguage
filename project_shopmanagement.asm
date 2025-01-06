.MODEL SMALL

    
    
    
DecimalPrinter macro var1 ;limit 4 hex bytes, 65535 decimal
    mov ax,var1
    
    mov bx,10000 
    mov dx,0
    div bx
    mov cx,dx
    mov dl,al
    add dl,30h
    mov ah,2
    int 21h 

    mov ax,cx
    mov bx,1000  
    mov dx,0
    div bx
    
    mov cx,dx
    mov dl,al
    add dl,30h
    mov ah,2
    int 21h
    
    mov ax,cx
    mov bx,100  
    mov dx,0
    div bx
    
    mov cx,dx
    mov dl,al
    add dl,30h
    mov ah,2
    int 21h 
    
    mov ax,cx
    mov bx,10  
    mov dx,0
    div bx
    
    mov cx,dx
    mov dl,al
    add dl,30h
    mov ah,2
    int 21h 
    
    mov dl,cl
    add dl,30h
    mov ah,2
    int 21h 
    
    
    endm

HighestSellingItem macro item1,item2,item3
    mov ax, item1
    mov bx,item2          ;; Takes item 1 item 2 item 3 revenue value as variables and places them in register
    mov cx,item3          ;; Firstly it checks if all values are zero (ie no sale made since system boot)
    cmp ax,0              ;; if at least one item revenue is non zero (all values are initialized as 0 anyway)
    jne nozero            ;; then the largest value finder code runs, else we jump way down  to print an error msg
    cmp bx,0
    jne nozero
    cmp cx,0
    jne nozero
    
    jmp AbruptEnd
    nozero:
    
    cmp ax,bx
    push ax               ;; in order to introduce stack, we first push ax into stack, if value in ax is bigger then okay
    jg item1bigger        ;; but if bx value was bigger than item1bigger conditional jump will be skipped, and we will pop ax, then push bx as it is the largest
    pop dx
    push bx
    jmp item2bigger
    item1bigger:
    pop dx           ;;pop the largest value out of stack to register dx to compare again to find largest one
    cmp dx,cx
    jg item1biggest
    jmp item3biggest
    item2bigger:
    cmp dx,cx
    jg item2biggest
    jmp item3biggest
    
    item1biggest:
    mov ah,9
    lea dx,biggest_item           ;; item?biggest jumps all print the biggest item str then the item name [?=itemm number]
    int 21h
    mov ah,9
    lea dx, item1_name
    int 21h
    jmp end
    
    item2biggest:
    mov ah,9
    lea dx,biggest_item
    int 21h
    mov ah,9
    lea dx, item2_name
    int 21h
    jmp end 
    
    item3biggest:
    mov ah,9
    lea dx,biggest_item
    int 21h
    mov ah,9
    lea dx, item3_name
    int 21h
    jmp end   
    
    AbruptEnd:
    mov ah,9
    lea dx,biggest_item
    int 21h                          ;;if all items revenue is 0, then init_state message is printed
    mov ah,9
    lea dx, init_state
    int 21h
    jmp end
    
    
    end:
    endm
    
    
    
    
    
    
    
    

StockAdder macro var1
    mov bx, var1
    add bx,cx       ;; the 2 digit input is stored in cl specifically, but since stock value is word so cx is used (0 has been moved to ch to avoid miscalc)
    mov var1,bx
    endm

SellItemProcess1 macro price,stock, cash_register, revenue
    mov bx, stock
    cmp bx,0
    je Itemdepleted1 
    cmp cx,bx   ;; cx contains the n value ie no of items
    jg StockExceeded1 
    
    sub bx,cx
    mov stock,bx
    mov bx, price  
    mov ax,0
    priceloop1: 
    add ax,bx
    loop priceloop1
    
    mov bx, cash_register
    add bx,ax
    mov cash_register,bx
    mov bx,revenue
    add bx,ax
    mov revenue,bx 
    jmp endpoint1
   
    
    StockExceeded1:
    mov ah,9
    lea dx, stockexceed
    int 21h 
    call newlinecursorzero
    mov ah,9
    lea dx, presskeytocontinue
    int 21h 
    mov ah,1
    int 21h
    jmp SellItemPage 
    
    Itemdepleted1:
    mov ah,9
    lea dx, itemdeplete
    int 21h 
    call newlinecursorzero
    mov ah,9
    lea dx, presskeytocontinue
    int 21h 
    mov ah,1
    int 21h
    jmp SellItemPage
    
    endpoint1:
    mov cx,ax
    endm

SellItemProcess2 macro price,stock, cash_register, revenue
    mov bx, stock
    cmp bx,0
    je Itemdepleted2 
    cmp cx,bx
    jg StockExceeded2 
    
    sub bx,cx
    mov stock,bx
    mov bx, price  
    mov ax,0
    priceloop2: 
    add ax,bx
    loop priceloop2
    
    mov bx, cash_register
    add bx,ax
    mov cash_register,bx
    mov bx,revenue
    add bx,ax
    mov revenue,bx 
    jmp endpoint2
   
    
    StockExceeded2:
    mov ah,9
    lea dx, stockexceed
    int 21h 
    call newlinecursorzero
    mov ah,9
    lea dx, presskeytocontinue
    int 21h 
    mov ah,1
    int 21h
    jmp SellItemPage 
    
    Itemdepleted2:
    mov ah,9
    lea dx, itemdeplete
    int 21h 
    call newlinecursorzero
    mov ah,9
    lea dx, presskeytocontinue
    int 21h 
    mov ah,1
    int 21h
    jmp SellItemPage
    
    endpoint2:
    mov cx,ax
    endm    
 
 
SellItemProcess3 macro price,stock, cash_register, revenue
    mov bx, stock
    cmp bx,0
    je Itemdepleted3 
    cmp cx,bx
    jg StockExceeded3 
    
    sub bx,cx
    mov stock,bx
    mov bx, price  
    mov ax,0
    priceloop3: 
    add ax,bx
    loop priceloop3
    
    mov bx, cash_register
    add bx,ax
    mov cash_register,bx
    mov bx,revenue
    add bx,ax
    mov revenue,bx 
    jmp endpoint3
   
    
    StockExceeded3:
    mov ah,9
    lea dx, stockexceed
    int 21h 
    call newlinecursorzero
    mov ah,9
    lea dx, presskeytocontinue
    int 21h 
    mov ah,1
    int 21h
    jmp SellItemPage 
    
    Itemdepleted3:
    mov ah,9
    lea dx, itemdeplete
    int 21h 
    call newlinecursorzero
    mov ah,9
    lea dx, presskeytocontinue
    int 21h 
    mov ah,1
    int 21h
    jmp SellItemPage
    
    endpoint3:
    mov cx,ax
    endm 
 
 
.STACK 100H

.DATA   
LoginWelcomeMessage db "Welcome to Shop X! Please Login to continue.$"
spacer db " $" 
arrowpointer db " ==> $" 
one db "1.) $" 
two db "2.) $"  
three db "3.) $"
dollarendermsg db " dollars$" 
dollarendermsg1 db " dollars from customer$"
userid db 04Dh,61h,73h,74h,65h,06Dh,61h        
password db 35h,34h,33h,61h,62h,63h,64h
userIDinput db 7 dup(?)
IDinputmsg db "User ID: $"
passwordinput db 7 dup(?)
passinputmsg db "Password: $"
InvalidCredentials db "Invalid Credentials! Press any key to go back to login screen. $" 
welcome db "Welcome Mastema! These are your options$"
success db "Success!$"
invalidnumber db "Please enter a number between 1 and 25!$"  
invalidnumber1 db "Please enter a number between 1 and 50!$"
presskeytocontinue db "Press a key to continue: $"      
;main menu strings  
PressHashToMainMenu db "Press # to return to main menu: $"
SelectorHash db "Select Item or press # to return to main menu: $"
PressNumberToContinue db "Pick an option to continue: $"
main_menu_cash_register_msg db "Amount in cash_register: $" 
main_menu_viewstock db "1.) View Stock$"   
main_menu_AddStock db "2.) Add Stock$"
main_menu_SellItem db "3.) Sell Products$" 
main_menu_ViewRevenue db "4.) View Revenue$"
main_menu_Logout db "5.) Logout$"   

main_menu_end_msg db "[!]: Make appropriate backups to prevent data loss during a failure!$"

; View stock page string
viewstockstr db "This page displays stock number for each item$" 


;AddStockPage
addstockstr db "Add stock from this page (Between 1 and 25)$" 
enternumber db "Enter a valid number between 1-25: $"


;SellItemPage 
sellitemstr db "Pick an item and quantity to sell(nonzero,50 per customer max)$"
enternumber1 db "Enter a valid number between 1-50: $"
stockexceed db "Number of items exceed stock amount. Restock or pick another item $" 
itemdeplete db "Item unavailable. Please select another item $"
sellsuccess db "Valid purchase! Please collect $"   

;ViewRevenuePage
ViewRevenuestr db "This page displays revenue generated from each item$" 

;Logoout
Logoutstr db "You will be logged out and won't be able to continue store activities. Continue?[y/anything else]: $"


;numerical data
cash_register dw 0 
item_1_stock dw 1  
item_2_stock dw 2
item_3_stock dw 3  

item_1_price dw 23   
item_2_price dw 47
item_3_price dw 73

item_1_revenue dw 0
item_2_revenue dw 0        ;;all item revenues are stored in this var, initialized with zeros
item_3_revenue dw 0  

temp db 0       ;;clear scr procedure interreupts logout choice input since it uses all registers so a variable stores input then clear scr does its job without deleting
                ;; single char input


;item names
item1_name db "Item 1$"
item2_name db "Item 2$"  
item3_name db "Item 3$"
;HIGHEST SELLING
biggest_item db "Highest selling item so far: $"
init_state db "Zero sale made since system boot!$"



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
    MOV BH,00 ;; bh indicates page number, 00 indicates page 0 so active page
    MOV DL,00   ;; dl indicates column number, 0 indicates column 0
    MOV DH,00    ;; dh indicates row number, 0 indicates row 0 . so bh=dl=dh=0 indicates cursor moved to start of page 0
    INT 10H
    
    
     
    ret
    clearscr endp  
newlinecursorzero proc  ;newline carriage return given a procedure form for modularity
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
call clearscr    ;screen clear procedure,not required under normal circumstances ie sys start
call hashloop                                                           ;    , but necessary for logout function to clear screen(main menu has its own clear screen call)
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

;;;;;;;;;;;;;;;;;;;;;;;;;Main menu start  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
MainMenu:
call clearscr   ;; clear scr clears the screen in order to print everyhting from startt
call hashloop  ;; prints 70 hashes in loop for decoration
call movepointertomiddle ;;moves mouse pointer a few chars forward, in order to print heading in the middle
mov ah,9 
lea dx,welcome      ;;print welcome message
int 21h
call newlinecursorzero   ;;carriage return new line given procedure form
call newlinecursorzero

mov ah,9
lea dx, main_menu_cash_register_msg  ;;main maenu cash register string
int 21h
DecimalPrinter cash_register  ;;macro prints value in cash register in decimal using macro
mov ah,9
lea dx, dollarendermsg  ;;writes dollar after number
int 21h 
call newlinecursorzero 

HighestSellingItem item_1_revenue,item_2_revenue,item_3_revenue ;;ccalls highest selling macro passing revenue variable of 3 items
call newlinecursorzero
call newlinecursorzero


mov ah,9
lea dx, main_menu_viewstock     ;;option string 1
int 21h  

call newlinecursorzero
mov ah,9
lea dx, main_menu_AddStock      ;;option string 2
int 21h


call newlinecursorzero
mov ah,9
lea dx, main_menu_SellItem       ;;option string 3
int 21h 

call newlinecursorzero
mov ah,9
lea dx, main_menu_ViewRevenue      ;;option string 4
int 21h
call newlinecursorzero
mov ah,9
lea dx, main_menu_Logout               ;;option string 5
int 21h 
call newlinecursorzero

call newlinecursorzero


mov ah,9
lea dx, main_menu_end_msg           ;;a warning message for decoration purposes
int 21h 
 
call newlinecursorzero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Main menu option end
call hashloop     ; hashloops  marking end of page
mov ah,9
lea dx,PressNumberToContinue    ;; a string prints which will state which option to choose
int 21h

mov ah,1     ;;single char input
int 21h

cmp al,31h
je ViewStockPage    ;;if input is 1
cmp al,32h
je AddStockPage        ;;if input is 2

cmp al,33h
je SellItemPage         ;;if input is 3

cmp al,34h
je ViewRevenue            ;;if input is4
cmp al,35h
je Logout                      ;;if input is 5



jmp MainMenu               ;;any other input other than 1-5 will reload main menu [end of main menu]
 
 
 
 ;;;;;;;;;;;;;;View stock Page ;;;;;;;;;;;;;;;;;;
ViewStockPage:
call clearscr
call hashloop
call movepointertomiddle
mov ah,9
lea dx,viewstockstr 
int 21h
call newlinecursorzero 
call newlinecursorzero
mov ah,9
lea dx,item1_name
int 21h  
mov ah,9
lea dx,arrowpointer
int 21h

DecimalPrinter item_1_stock    

call newlinecursorzero
mov ah,9
lea dx,item2_name
int 21h 
mov ah,9
lea dx,arrowpointer
int 21h
DecimalPrinter item_2_stock

call newlinecursorzero
mov ah,9
lea dx,item3_name
int 21h   
mov ah,9
lea dx,arrowpointer
int 21h
DecimalPrinter item_3_stock
call newlinecursorzero
call newlinecursorzero


mov ah,9
lea dx, main_menu_end_msg
int 21h                        

                       
call newlinecursorzero
call hashloop
mov ah,9
lea dx, PressHashToMainMenu
int 21h

mov ah,1
int 21h 

cmp al,23h
je MainMenu

jmp ViewStockPage


 ;;;;;;;;;;;;;;Add Stock Page ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
AddStockPage:
call clearscr
call hashloop
call movepointertomiddle
mov ah,9
lea dx, addstockstr 
int 21h
call newlinecursorzero    
call newlinecursorzero
mov ah,9
lea dx,one
int 21h 
mov ah,9
lea dx,item1_name
int 21h 

call newlinecursorzero   
mov ah,9
lea dx,two
int 21h 
mov ah,9
lea dx,item2_name
int 21h


call newlinecursorzero  
mov ah,9
lea dx,three
int 21h 
mov ah,9
lea dx,item3_name
int 21h

call newlinecursorzero
call newlinecursorzero


mov ah,9
lea dx, main_menu_end_msg
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



sub al,30h
mov bl,10
mul bl       ;2 digit deccimal input
mov cl,al
mov ah,1
int 21h
sub al,30h
add cl,al 
mov ch,0


cmp cl,0
jle InputErrorAddStock1
cmp cl,26
jge InputErrorAddStock1 

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

sub al,30h
mov bl,10
mul bl
mov cl,al
mov ah,1
int 21h
sub al,30h
add cl,al 
mov ch,0

cmp cl,0
jle InputErrorAddStock2
cmp cl,26
jge InputErrorAddStock2  
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

sub al,30h
mov bl,10
mul bl
mov cl,al
mov ah,1
int 21h
sub al,30h
add cl,al
mov ch,0

cmp cl,0
jle InputErrorAddStock3
cmp cl,26
jge InputErrorAddStock3 
 
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


 ;;;;;;;;;;;START OF SELL ITEM;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SellItemPage:   

call clearscr
call hashloop

mov ah,9
lea dx, sellitemstr 
int 21h
call newlinecursorzero    
call newlinecursorzero
mov ah,9
lea dx,one
int 21h 
mov ah,9
lea dx,item1_name
int 21h

mov ah,9
lea dx,spacer
int 21h  

mov ah,9
lea dx,arrowpointer
int 21h 

DecimalPrinter item_1_price
mov ah,9
lea dx,dollarendermsg
int 21h

call newlinecursorzero   
mov ah,9
lea dx,two
int 21h 
mov ah,9
lea dx,item2_name
int 21h

mov ah,9
lea dx,spacer
int 21h  

mov ah,9
lea dx,arrowpointer
int 21h 

DecimalPrinter item_2_price
mov ah,9
lea dx,dollarendermsg
int 21h


call newlinecursorzero  
mov ah,9
lea dx,three
int 21h 
mov ah,9
lea dx,item3_name
int 21h


mov ah,9
lea dx,spacer
int 21h  

mov ah,9
lea dx,arrowpointer
int 21h 

DecimalPrinter item_3_price
mov ah,9
lea dx,dollarendermsg
int 21h




call newlinecursorzero
call newlinecursorzero


mov ah,9
lea dx, main_menu_end_msg
int 21h    
call newlinecursorzero
call hashloop   

mov ah,9
lea dx, SelectorHash
int 21h


mov ah,1
int 21h
cmp al, 31h
je SellItem1   

cmp al, 32h       ;;;;Sub menu redirection for 3 items
je SellItem2

cmp al, 33h
je SellItem3

cmp al, 23h
je MainMenu  

jmp SellItemPage ;any invalid input will refresh page  





 ;sell item 1 logic
SellItem1:    
call clearscr
call hashloop

mov ah,9
lea dx, enternumber1
int 21h 

call newlinecursorzero
mov ah,1
int 21h  



sub al,30h
mov bl,10
mul bl       ;2 digit deccimal input
mov cl,al
mov ah,1
int 21h
sub al,30h
add cl,al 
mov ch,0


cmp cl,0
jle InputErrorSellItem1
cmp cl,51
jge InputErrorSellItem1 

call newlinecursorzero


 
SellItemProcess1 item_1_price,item_1_stock,cash_register,item_1_revenue    
call newlinecursorzero
mov ah,9
lea dx, sellsuccess
int 21h   

DecimalPrinter cx
mov ah,9
lea dx, dollarendermsg1
int 21h 

call newlinecursorzero
call hashloop 
mov ah,9
lea dx, presskeytocontinue
int 21h
mov ah,1
int 21h
jmp SellItemPage   


InputErrorSellITem1:
call newlinecursorzero
mov ah,9
lea dx, invalidnumber1
int 21h
call newlinecursorzero 
mov ah,9
lea dx, presskeytocontinue
int 21h  
mov ah,1
int 21h
jmp SellItem1   




 ;sell item 2 logic
SellItem2:    
call clearscr
call hashloop

mov ah,9
lea dx, enternumber1
int 21h 

call newlinecursorzero
mov ah,1
int 21h  



sub al,30h
mov bl,10
mul bl       ;2 digit deccimal input
mov cl,al
mov ah,1
int 21h
sub al,30h
add cl,al 
mov ch,0


cmp cl,0
jle InputErrorSellItem2
cmp cl,51
jge InputErrorSellItem2 

call newlinecursorzero


 
SellItemProcess2 item_2_price,item_2_stock,cash_register,item_2_revenue    
call newlinecursorzero
mov ah,9
lea dx, sellsuccess
int 21h   

DecimalPrinter cx
mov ah,9
lea dx, dollarendermsg1
int 21h 

call newlinecursorzero
call hashloop 
mov ah,9
lea dx, presskeytocontinue
int 21h
mov ah,1
int 21h
jmp SellItemPage   


InputErrorSellITem2:
call newlinecursorzero
mov ah,9
lea dx, invalidnumber1
int 21h
call newlinecursorzero 
mov ah,9
lea dx, presskeytocontinue
int 21h  
mov ah,1
int 21h
jmp SellItem2  



 ;sell item 3 logic
SellItem3:    
call clearscr
call hashloop

mov ah,9
lea dx, enternumber1
int 21h 

call newlinecursorzero
mov ah,1
int 21h  



sub al,30h
mov bl,10
mul bl       ;2 digit deccimal input
mov cl,al
mov ah,1
int 21h
sub al,30h
add cl,al 
mov ch,0


cmp cl,0
jle InputErrorSellItem3
cmp cl,51
jge InputErrorSellItem3 

call newlinecursorzero


 
SellItemProcess3 item_3_price,item_3_stock,cash_register,item_3_revenue    
call newlinecursorzero
mov ah,9
lea dx, sellsuccess
int 21h   

DecimalPrinter cx
mov ah,9
lea dx, dollarendermsg1
int 21h 

call newlinecursorzero
call hashloop 
mov ah,9
lea dx, presskeytocontinue
int 21h
mov ah,1
int 21h
jmp SellItemPage   


InputErrorSellITem3:
call newlinecursorzero
mov ah,9
lea dx, invalidnumber1
int 21h
call newlinecursorzero 
mov ah,9
lea dx, presskeytocontinue
int 21h  
mov ah,1
int 21h
jmp SellItem3 

;;;;;;;;;END OF SELL ITEM;;;;;;;;;;;;;;;;;



  ;;;;;START VIEW REVENUE;;;;;;;;;;;;;;;;;;;;;;;
  
ViewRevenue:
call clearscr             ;;clears screen
call hashloop              ;;prints hashes
call movepointertomiddle    ;;moves moouse pointer to middle
mov ah,9
lea dx,ViewRevenuestr     ;;prints header string for this page
int 21h
call newlinecursorzero 
call newlinecursorzero
mov ah,9
lea dx,item1_name               ;;item 1 name
int 21h  
mov ah,9
lea dx,arrowpointer           ;; prints an arrow ==>
int 21h

DecimalPrinter item_1_revenue   ;; prints value stored in item no revenue in decimal 
mov ah,9
lea dx,dollarendermsg         ;;ends numerical value with dollars ie 00010 dollars
int 21h     

call newlinecursorzero
mov ah,9
lea dx,item2_name                      ;;similar repetitions
int 21h 
mov ah,9
lea dx,arrowpointer
int 21h
DecimalPrinter item_2_revenue 
mov ah,9
lea dx,dollarendermsg
int 21h
                                            ;;similar
call newlinecursorzero
mov ah,9
lea dx,item3_name
int 21h   
mov ah,9
lea dx,arrowpointer
int 21h                                           ;;similar
DecimalPrinter item_3_revenue
mov ah,9
lea dx,dollarendermsg
int 21h 

call newlinecursorzero
call newlinecursorzero


mov ah,9
lea dx, main_menu_end_msg      ;;decoration messager
int 21h  

call newlinecursorzero       ;; end of that page
call hashloop
mov ah,9
lea dx, PressHashToMainMenu        ;; print string saying we can return pressing a certain key
int 21h

mov ah,1
int 21h
cmp al,23h         ;; if the key is #, return to main menu
je MainMenu            ;; if not reload that page ie prints the whole revenue page again
jmp ViewRevenue        


Logout:
call clearscr
call newlinecursorzero
mov ah,9
lea dx,Logoutstr
int 21h
mov ah,1
int 21h


cmp al,79h
je bigbang

jmp MainMenu



 









 

;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
