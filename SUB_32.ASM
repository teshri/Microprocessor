.model small  
 .data  
 op1 dd 12345678h                                                         
 op2 dd 11111111h  
 ans dd ?  
 .code  
      mov      ax, @data  
      mov      ds, ax  
      mov      ax, word ptr op1          ; lsb of number1 in ax  
      mov      bx, word ptr op1+2        ; msb of number1 in bx   
      mov      cx, word ptr op2          ; lsb of number2 in cx  
      mov      dx, word ptr op2+2        ; msb of number1 in dx  
      sub      ax, cx                    ; subtract lsb + lsb  
      mov      word ptr ans, ax          ; lsb answer  
      mov      word ptr ans+2, bx        ; msb answer  
      mov      bx, word ptr ans+2        ; Result in reg bx  
      mov      dh, 2  
 l1:     mov      ch, 04h                ; Count of digits to be displayed  
      mov      cl, 04h                   ; Count to roll by 4 bits  
 l2:     rol      bx, cl                 ; roll bl so that msb comes to lsb   
      mov      dl, bl                    ; load dl with data to be displayed  
      and      dl, 0fH                   ; get only lsb  
      cmp      dl, 09                    ; check if digit is 0-9 or letter A-F  
      jbe      l4  
      add      dl, 07                    ; if letter add 37H else only add 30H  
 l4:     add      dl, 30H  
      mov      ah, 02                    ; INT 21H (Display character)  
      int      21H  
      dec      ch                        ; Decrement Count  
      jnz      l2  
      dec      dh  
      cmp      dh, 0  
      mov      bx, word ptr ans          ; display lsb of answer  
      jnz      l1  
      mov      ah, 4ch                   ; Terminate Program  
      int      21h  
 end 