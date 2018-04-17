.model huge    
.code
org 100h

game: jmp main
        
		;===================================TITLE==================================
		pixl1 db 219, 10, 13, "$"
		pixl2 db 219, 219, 10, 13, "$"
		pixl3 db 219, 219, 219, 10, 13, "$"
		pixl4 db 219, 219, 219, 219, 10, 13, "$"
		pixl5 db 219, 219, 219, 219, 219, 10, 13, "$"
		pixl6 db 219, 219, 219, 219, 219, 219, 10, 13, "$"
		
		pix_2 db 219, 219, 221, 10, 13, "$"
		pix_3 db 219, 219, 219, 221, 10, 13, "$"
		pix_4 db 219, 219, 219, 219, 221, 10, 13, "$"
		pix_5 db 219, 219, 219, 219, 219, 221, 10, 13, "$"
		pix_6 db 219, 219, 219, 219, 219, 219, 221, 10, 13, "$"
		begin db 175, " PRESS SPACE TO PLAY! ", 174, "$"
		prompt db "DO YOU WANT TO PLAY AGAIN? [Y/N] $"
		
		question db "What country this flag represents? $"
		counter db "SCORE: $"
		zero db "0 $"
		wrong db '$$$$$'
		score dw ?
		points db '$$$$$'
		correct_ db "~ CORRECT! ~$"
		wrong_ db "* WRONG! *$"
		buffer db "PRESS ENTER!$"
		
		;===================================STAGES==================================
		easy db "EASY (1 point) $"
		average db "AVERAGE (5 points) $"
		hard db "HARD (10 points) $"
		
		;==================================CHOICES==================================
		choices1 db "[A] Bangladesh   [B] Japan   [C] Palau    [D] Kazakhstan $" ;B
		choices2 db "[A] Japan   [B] North Korea  [C] South Korea   [D] China $" ;C
		choices3 db "[A] France   [B] United Kingdom    [C] Canada    [D] USA $" ;C
		choices4 db "[A] Philippines   [B] Chile    [C] Cuba    [D] Czech Rep $" ;A
		choices5 db "[A] Netherlands  [B] Cambodia   [C] Russia  [D] Thailand $" ;D 
		choices6 db "[A] Russia    [B] Netherlands    [C] France    [D] Italy $" ;C
		choices7 db "[A] France   [B] Russia   [C] Thailand   [D] Netherlands $" ;B
		choices8 db "[A] Yugoslavia   [B] Netherlands  [C] Thailand   [D] USA $" ;B
		choices9 db "[A] Indonesia   [B] Singapore    [C] Poland   [D] Monaco $" ;C
		choices10 db "[A] Indonesia   [B] Monaco    [C] Singapore   [D] Poland $" ;A
		choices11 db "[A] Denmark    [B] Iceland      [C] Sweden    [D] Norway $" ;D
		choices12 db "[A] Norway    [B] Sweden      [C] Iceland    [D] Finland $" ;C
		choices13 db "[A] Sweden    [B] Iceland      [C] Norway    [D] Denmark $" ;A
		choices14 db "[A] Denmark    [B] Finland    [C] Sweden     [D] Iceland $" ;B
		choices15 db "[A] Sweden    [B] Norway      [C] Iceland    [D] Denmark $" ;D
		
		;================================PIXELS WIDTH================================
		pix1 db 219, 219, 10, 13, "$"
		pix2 db 219, 219, 219, 219, 10, 13, "$"
		pix3 db 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix4 db 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix5 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix6 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix7 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix8 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix9 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix10 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix12 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix22 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"
		pix28 db 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 10, 13, "$"

main	proc near

		;================================TITLE SCREEN================================
		call game_title
		
        mov ch, 32 ;CHECKS IF SPACE
        mov ah, 01h
        int 10h
        mov ah, 01h
        int 21h
		
        cmp al, 20h
        je play

		cmp al, 1Bh ;CHECKS IF ESCAPE
		je exit
        jne main
		
exit:   int 20h

gameover:	call game_over

play:	call level1
		cmp wrong, 30h
		je gameover
		call level2
		cmp wrong, 30h
		je gameover
		call level3
		cmp wrong, 30h
		je gameover
		call level4
		cmp wrong, 30h
		je gameover
		call level5
		cmp wrong, 30h
		je gameover
		call level6
		cmp wrong, 30h
		je gameover
		call level7
		cmp wrong, 30h
		je gameover
		call level8
		cmp wrong, 30h
		je gameover
		call level9
		cmp wrong, 30h
		je gameover
		call level10
		cmp wrong, 30h
		je gameover
		call level11
		cmp wrong, 30h
		je gameover2
		call level12
		cmp wrong, 30h
		je gameover2
		call level13
		cmp wrong, 30h
		je gameover2
		call level14
		cmp wrong, 30h
		je gameover2
		call level15
		cmp wrong, 30h
		je gameover2
		call final
		jmp main
		
main endp

gameover2:	call game_over
;===================================LEVEL 1===================================
level1	proc near
		call japan_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		mov score, 0 ;INITIAL SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov wrong, 33h ;INITIAL WRONG;
				
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 1;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices1
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 1;
		cmp bl, 1Bh
		je exit1
		cmp bl, 'B'
		je correct1
		cmp bl, 'b'
		je correct1
        jne wrong1
		cmp cl, 0dh
		
		exit1: int 20h
		
		wrong1:
			sub wrong, 1
			jmp wrongprompt1
				
		correct1:
			call plus1
			jmp correctprompt1
			
		wrongprompt1:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt1:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		ret
level1	endp

;===================================LEVEL 2===================================
level2	proc near
		call sokor_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 2;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices2
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 2;
		cmp bl, 1Bh
		je exit2
		cmp bl, 'C'
		je correct2
		cmp bl, 'c'
		je correct2
        jne wrong2
		cmp cl, 0dh
		
		exit2: int 20h
		
		wrong2:
			sub wrong, 1
			jmp wrongprompt2
		correct2:
			call plus1
			jmp correctprompt2
			
		wrongprompt2:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt2:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level2	endp

;===================================LEVEL 3===================================
level3	proc near
		call canada_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 3;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices3
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 3;
		cmp bl, 1Bh
		je exit3
		cmp bl, 'C'
		je correct3
		cmp bl, 'c'
		je correct3
        jne wrong3
		cmp cl, 0dh
		
		exit3: int 20h
		
		wrong3:
			sub wrong, 1
			jmp wrongprompt3
		correct3:
			call plus1
			jmp correctprompt3
			
		wrongprompt3:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt3:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level3	endp

;===================================LEVEL 4===================================
level4	proc near
		call ph_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 4;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices4
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 4;
		cmp bl, 1Bh
		je exit4
		cmp bl, 'A'
		je correct4
		cmp bl, 'a'
		je correct4
        jne wrong4
		cmp cl, 0dh
		
		exit4: int 20h
		
		wrong4:
			sub wrong, 1
			jmp wrongprompt4
		correct4:
			call plus1
			jmp correctprompt4
			
		wrongprompt4:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt4:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level4	endp

;===================================LEVEL 5===================================
level5	proc near
		call thai_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 5;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices5
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 5;
		cmp bl, 1Bh
		je exit5
		cmp bl, 'D'
		je correct5
		cmp bl, 'd'
		je correct5
        jne wrong5
		cmp cl, 0dh
		
		exit5: int 20h
		
		wrong5:
			sub wrong, 1
			jmp wrongprompt5
		correct5:
			call plus1
			jmp correctprompt5
			
		wrongprompt5:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt5:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level5	endp

;===================================LEVEL 6===================================
level6	proc near
		call france_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 6;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices6
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 6;
		cmp bl, 1Bh
		je exit6
		cmp bl, 'C'
		je correct6
		cmp bl, 'c'
		je correct6
        jne wrong6
		cmp cl, 0dh
		
		exit6: int 20h
		
		wrong6:
			sub wrong, 1
			jmp wrongprompt6
		correct6:
			call plus5
			jmp correctprompt6
			
		wrongprompt6:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt6:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level6	endp

;===================================LEVEL 7===================================
level7	proc near
		call russia_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 7;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices7
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 7;
		cmp bl, 1Bh
		je exit7
		cmp bl, 'B'
		je correct7
		cmp bl, 'b'
		je correct7
        jne wrong7
		cmp cl, 0dh
		
		exit7: int 20h
		
		wrong7:
			sub wrong, 1
			jmp wrongprompt7
		correct7:
			call plus5
			jmp correctprompt7
			
		wrongprompt7:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt7:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level7	endp

;===================================LEVEL 8===================================
level8	proc near
		call nether_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 8;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices8
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 8;
		cmp bl, 1Bh
		je exit8
		cmp bl, 'B'
		je correct8
		cmp bl, 'b'
		je correct8
        jne wrong8
		cmp cl, 0dh
		
		exit8: int 20h
		
		wrong8:
			sub wrong, 1
			jmp wrongprompt8
		correct8:
			call plus5
			jmp correctprompt8
			
		wrongprompt8:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt8:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level8	endp

;===================================LEVEL 9===================================
level9	proc near
		call poland_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 9;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices9
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 9;
		cmp bl, 1Bh
		je exit9
		cmp bl, 'C'
		je correct9
		cmp bl, 'c'
		je correct9
        jne wrong9
		cmp cl, 0dh
		
		exit9: int 20h
		
		wrong9:
			sub wrong, 1
			jmp wrongprompt9
		correct9:
			call plus5
			jmp correctprompt9
			
		wrongprompt9:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt9:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level9	endp

;===================================LEVEL 10===================================
level10	proc near
		call indo_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 10;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices10
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 10;
		cmp bl, 1Bh
		je exit10
		cmp bl, 'A'
		je correct10
		cmp bl, 'a'
		je correct10
        jne wrong10
		cmp cl, 0dh
		
		exit10: int 20h
		
		wrong10:
			sub wrong, 1
			jmp wrongprompt10
		correct10:
			call plus5
			jmp correctprompt10
			
		wrongprompt10:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt10:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level10	endp

;===================================LEVEL 11===================================
level11	proc near
		call norway_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 11;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices11
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 11;
		cmp bl, 1Bh
		je exit11
		cmp bl, 'D'
		je correct11
		cmp bl, 'd'
		je correct11
        jne wrong11
		cmp cl, 0dh
		
		exit11: int 20h
		
		wrong11:
			sub wrong, 1
			jmp wrongprompt11
		correct11:
			call plus10
			jmp correctprompt11
			
		wrongprompt11:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt11:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level11	endp

;===================================LEVEL 12===================================
level12	proc near
		call icelnd_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 12;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices12
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 12;
		cmp bl, 1Bh
		je exit12
		cmp bl, 'C'
		je correct12
		cmp bl, 'c'
		je correct12
        jne wrong12
		cmp cl, 0dh
		
		exit12: int 20h
		
		wrong12:
			sub wrong, 1
			jmp wrongprompt12
		correct12:
			call plus10
			jmp correctprompt12
			
		wrongprompt12:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt12:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level12	endp

;===================================LEVEL 13===================================
level13	proc near
		call sweden_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 13;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices13
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 13;
		cmp bl, 1Bh
		je exit13
		cmp bl, 'A'
		je correct13
		cmp bl, 'a'
		je correct13
        jne wrong13
		cmp cl, 0dh
		
		exit13: int 20h
		
		wrong13:
			sub wrong, 1
			jmp wrongprompt13
		correct13:
			call plus10
			jmp correctprompt13
			
		wrongprompt13:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt13:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level13	endp

;===================================LEVEL 14===================================
level14	proc near
		call finlnd_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 14;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices14
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 14;
		cmp bl, 1Bh
		je exit14
		cmp bl, 'B'
		je correct14
		cmp bl, 'b'
		je correct14
        jne wrong14
		cmp cl, 0dh
		
		exit14: int 20h
		
		wrong14:
			sub wrong, 1
			jmp wrongprompt14
		correct14:
			call plus10
			jmp correctprompt14
			
		wrongprompt14:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt14:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level14	endp

;===================================LEVEL 15===================================
level15	proc near
		call denmrk_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;QUESTION 15;
		mov ah, 2
		mov dl, 12
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset choices15
		mov bl, 00Fh
		mov cx, 56
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 19
		int 10h

		mov ah, 9
		mov dx, offset question
		mov bl, 00Fh
		mov cx, 35
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

        mov ah, 1
        int 21h
        mov cl, al
        mov ah, 2
        int 21h
		
		;ANSWER 15;
		cmp bl, 1Bh
		je exit15
		cmp bl, 'D'
		je correct15
		cmp bl, 'd'
		je correct15
        jne wrong15
		cmp cl, 0dh
		
		exit15: int 20h
		
		wrong15:
			sub wrong, 1
			jmp wrongprompt15
		correct15:
			call plus10
			jmp correctprompt15
			
		wrongprompt15:
			call wrongg
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
		
		correctprompt15:
			call correctt
			
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h
			
			cmp bl, 0dh
			ret
			
		ret
level15	endp

;===================================FINAL===================================
final	proc near
		call denmrk_flag
		
		;SCORE COUNT;
		mov ah, 2
		mov dl, 59
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset counter
		mov bl, 00Fh
		mov cx, 7
		int 10h
		int 21h
		
		;DISPLAY SCORE;
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		;WRONG COUNT;
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset zero
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 40
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset wrong
		mov bl, 00Fh
		mov cx, 1
		int 10h
		int 21h
		
		;PRESS ENTER;
		mov ah, 2
		mov dl, 34
		mov dh, 21
		int 10h

		mov ah, 9
		mov dx, offset buffer
		mov bl, 08Fh
		mov cx, 12
		int 10h
		int 21h
		
		;INPUT;
        mov ah, 1
        int 21h
        mov bl, al
		mov dl, ''
        mov ah, 2
        int 21h

		;PRESS ENTER;
		cmp bl, 0Dh
		je temp_
        jne temp_
			
		temp_:
			call congrats

final	endp

correctt	proc near
			mov ah, 2
			mov dl, 34
			mov dh, 23
			int 10h

			mov ah, 9
			mov dx, offset correct_
			mov bl, 00Ah
			mov cx, 12
			int 10h
			int 21h
			
			ret
correctt	endp


wrongg		proc near
			mov ah, 2
			mov dl, 35
			mov dh, 23
			int 10h

			mov ah, 9
			mov dx, offset wrong_
			mov bl, 004h
			mov cx, 10
			int 10h
			int 21h
			
			ret
wrongg		endp

;===================================SCORES===================================
plus1	proc near
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		add score, 1
		ret
plus1	endp

plus5	proc near
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		add score, 5
		ret
plus5	endp

plus10	proc near
		mov si, offset points	
		mov ax, score
		call convert
				
		mov ah, 2
		mov dl, 66
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset points
		mov bl, 00Fh
		mov cx, 2
		int 10h
		int 21h
		
		add score, 10
		ret
plus10	endp

;===================================CONVERTER===================================
convert	proc near
		mov  cx, 5
		mov  di, offset points
	
		dollars_loop:
			mov  bl, '$'
			mov  [di], bl
			inc  di
			loop dollars_loop
 
		mov  bx, 10
		mov  cx, 0
				
		cycle1:
			mov  dx, 0
			div  bx
			push dx
			inc  cx
			cmp  ax, 0
			jne  cycle1
					
		cycle2:
			pop  dx        
			add  dl, 48
			mov  [si], dl
			inc  si
			loop cycle2
	
		ret
convert	endp 

;======================================GRAPHICS======================================
game_title	proc near
			mov ax, 3
			int 10h

			;======================================GUESS======================================
			
			mov ah, 2
			mov dl, 26
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 019h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 39
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 019h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 46
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 019h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 52
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 019h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 25
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 39
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 51
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 25
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix_3
			mov bl, 019h
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 39
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 019h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 019h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 51
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 019h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 25
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 39
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 48
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 54
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 019h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 019h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 019h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 39
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 019h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 019h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 51
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 019h
			mov cx, 4
			int 10h
			int 21h
			;======================================THE======================================
			
			mov ah, 2
			mov dl, 31
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_6
			mov bl, 06Eh
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 06Eh
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_6
			mov bl, 06Eh
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 06Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 06Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 06Eh
			mov cx, 5
			int 10h
			int 21h
			
			;======================================FLAG======================================
			
			mov ah, 2
			mov dl, 29
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 04Ch
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 04Ch
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 49
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 04Ch
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 41
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 48
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 04Ch
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 41
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 48
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 51
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix_3
			mov bl, 04Ch
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 41
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix_6
			mov bl, 04Ch
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 48
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 52
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 04Ch
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 41
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 04Ch
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 49
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 04Ch
			mov cx, 4
			int 10h
			int 21h
			
			;======================================QUESTION MARK 1======================================
			mov ah, 2
			mov dl, 70
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 002h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 72
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 082h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 69
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 082h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 73
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 082h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 73
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 082h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 72
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 082h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 71
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 082h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 71
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 082h
			mov cx, 2
			int 10h
			int 21h
			
			;SHIFT;
			mov ah, 2
			mov dl, 68
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0A0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 67
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0A0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 71
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0A0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 71
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0A0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 70
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0A0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 69
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0A0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 69
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0A0h
			mov cx, 2
			int 10h
			int 21h
			
			;======================================QUESTION MARK 2======================================
			
			mov ah, 2
			mov dl, 11
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 003h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 13
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 10
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 14
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 14
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 13
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B0h
			mov cx, 2
			int 10h
			int 21h
			
			;SHIFT;
			mov ah, 2
			mov dl, 9
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 083h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 8
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 083h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 083h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 083h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 11
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 083h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 10
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 083h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 10
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 083h
			mov cx, 2
			int 10h
			int 21h
			
			;======================================QUESTION MARK 3======================================
			mov ah, 2
			mov dl, 63
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 005h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 61
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 085h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 60
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 085h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 64
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 085h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 64
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 085h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 63
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 085h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 62
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 085h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 62
			mov dh, 19
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 085h
			mov cx, 2
			int 10h
			int 21h
			
			;SHIFT;
			mov ah, 2
			mov dl, 65
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0D0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 62
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0D0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 66
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0D0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 66
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0D0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 65
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0D0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 64
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0D0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 64
			mov dh, 19
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0D0h
			mov cx, 2
			int 10h
			int 21h
			
			;======================================QUESTION MARK 4======================================
			mov ah, 2
			mov dl, 19
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 006h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 21
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 086h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 086h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 22
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 086h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 22
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 086h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 21
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 086h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 086h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 086h
			mov cx, 2
			int 10h
			int 21h
			
			;SHIFT;
			mov ah, 2
			mov dl, 17
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0E0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 16
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0E0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0E0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0E0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 19
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0E0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0E0h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0E0h
			mov cx, 2
			int 10h
			int 21h
			
			;PROMPT;
			mov ah, 2
			mov dl, 30
			mov dh, 21
			int 10h

			mov ah, 9
			mov dx, offset begin
			mov bl, 08Fh
			mov cx, 24
			int 10h
			int 21h
			
			ret
game_title endp

congrats	proc near
			mov ax, 3
			int 10h

			;======================================SPARK TOP 1======================================
			mov ah, 2
			mov dl, 71
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 70
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 71
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 06Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 72
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 69
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 70
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl3
			mov bl, 06Eh
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 73
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 70
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 71
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 06Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 72
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 71
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			;======================================SPARK TOP 2======================================
			mov ah, 2
			mov dl, 9
			mov dh, 2
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 8
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 9
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 06Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 10
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 7
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 8
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl3
			mov bl, 06Eh
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 11
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 8
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 9
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 06Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 10
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 9
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			;======================================CONGRATS!======================================
			
			mov ah, 2
			mov dl, 13
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_3
			mov bl, 0E6h
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 34
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 0E6h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 48
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 54
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_6
			mov bl, 0E6h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 62
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 67
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 16
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 19
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 23
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_6
			mov bl, 0E6h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 44
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 47
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 51
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 61
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 67
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 19
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 23
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_3
			mov bl, 0E6h
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_3
			mov bl, 0E6h
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 44
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 47
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 51
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 61
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 0E6h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 67
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 16
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 19
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 23
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 37
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_5
			mov bl, 0E6h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 47
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_6
			mov bl, 0E6h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 64
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 13
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 34
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 44
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 47
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 51
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 61
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_4
			mov bl, 0E6h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 67
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix_2
			mov bl, 0E6h
			mov cx, 2
			int 10h
			int 21h
			
			;======================================SPARK BELOW 1======================================
			mov ah, 2
			mov dl, 14
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 13
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 14
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 06Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 15
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 13
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl3
			mov bl, 06Eh
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 16
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 13
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 14
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 06Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 15
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 14
			mov dh, 19
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			;======================================SPARK BELOW 2======================================
			mov ah, 2
			mov dl, 66
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 65
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 66
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 06Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 67
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 64
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 65
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl3
			mov bl, 06Eh
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 68
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 65
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 66
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 06Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 67
			mov dh, 18
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 66
			mov dh, 19
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 08Eh
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 25
			mov dh, 19
			int 10h

			mov ah, 9
			mov dx, offset prompt
			mov bl, 00Fh
			mov cx, 32
			int 10h
			int 21h
			
			call check
congrats	endp

;=====================================GAME OVER======================================
game_over	proc near
			mov ax, 3
			int 10h
			
			;======================================GAME======================================
			mov ah, 2
			mov dl, 29
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl4
			mov bl, 0B1h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl4
			mov bl, 0B1h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 47
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pixl5
			mov bl, 0B1h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 39
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl3
			mov bl, 0B1h
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 46
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl3
			mov bl, 0B1h
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 31
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl3
			mov bl, 0B1h
			mov cx, 3
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 39
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 45
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl1
			mov bl, 0B1h
			mov cx, 1
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 47
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pixl4
			mov bl, 0B1h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pixl6
			mov bl, 0B1h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 47
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pixl4
			mov bl, 0B1h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 35
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 39
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 42
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 47
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 0B1h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pixl5
			mov bl, 0B1h
			mov cx, 5
			int 10h
			int 21h
			
			;======================================OVER======================================
			mov ah, 2
			mov dl, 30
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pixl4
			mov bl, 093h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 43
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pixl5
			mov bl, 093h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 49
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pixl5
			mov bl, 093h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 43
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 49
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 53
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 43
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl4
			mov bl, 093h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 49
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 53
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 29
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 33
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 43
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 49
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pixl5
			mov bl, 093h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl4
			mov bl, 093h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 43
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl5
			mov bl, 093h
			mov cx, 5
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 49
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 53
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pixl2
			mov bl, 093h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 19
			int 10h

			mov ah, 9
			mov dx, offset prompt
			mov bl, 00Fh
			mov cx, 32
			int 10h
			int 21h
			
			call check
			
game_over	endp

check		proc near
			;INPUT;
			mov ah, 1
			int 21h
			mov bl, al
			mov dl, ''
			mov ah, 2
			int 21h

			mov ah, 1
			int 21h
			mov cl, al
			mov ah, 2
			int 21h

			cmp bl, 'Y'
			je play_
			cmp bl, 'y'
			je play_
			cmp bl, 'N'
			je exit_
			cmp bl, 'n'
			je exit_
			jne gameover_
			cmp cl, 0dh
			
			play_: call main
			gameover_: call game_over
			exit_: int 20h
			
check		endp

;=====================================JAPAN FLAG=====================================
japan_flag  proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset easy
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 34
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 004h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 004h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 004h
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 004h
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 004h
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 004h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 004h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 34
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			ret
japan_flag 	endp

;=================================SOUTH KOREA FLAG===================================
sokor_flag  proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset easy
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h

			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 24
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 22
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 54
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 58
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 24
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 34
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 60
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 22
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 004h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 58
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 004h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 004h
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 001h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 004h
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 40
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 46
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h

			mov ah, 2
			mov dl, 34
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix5
			mov bl, 001h
			mov cx, 10
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 48
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 004h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 001h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 22
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 001h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 58
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 22
			mov dh, 14
			int 10h

			mov ah, 2
			mov dl, 20
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 24
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
		 
			mov ah, 2
			mov dl, 34
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 001h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 60
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 22
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 26
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 54
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 58
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 24
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 000h
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h

			ret
sokor_flag 	endp

;====================================CANADA FLAG====================================
canada_flag	proc near
			mov ax, 3
			int 10h

			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset easy
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 004h
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 004h
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 46
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 36
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 004h
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 46
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix12
			mov bl, 004h
			mov cx, 24
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 004h
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 004h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 32
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 004h
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 38
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 56
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 004h
			mov cx, 12
			int 10h
			int 21h
			
			ret
canada_flag	endp

;==================================PHILIPPINE FLAG==================================
ph_flag		proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset easy
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 00Fh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 00Fh
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 14
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 00Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix5
			mov bl, 00Fh
			mov cx, 10
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 00Fh
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 16
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 00Fh
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix8
			mov bl, 00Fh
			mov cx, 16
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 14
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Eh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 24
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 00Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 16
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 20
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 00Fh
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix6
			mov bl, 00Fh
			mov cx, 12
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix5
			mov bl, 00Fh
			mov cx, 10
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 00Fh
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 14
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 00Eh
			mov cx, 2
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix1
			mov bl, 00Fh
			mov cx, 2
			int 10h
			int 21h
			
			ret
ph_flag endp

;=====================================THAI FLAG=====================================
thai_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset easy
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			ret
thai_flag	endp

;====================================FRENCH FLAG====================================
france_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset average
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 001h
			mov cx, 18
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix10
			mov bl, 00Fh
			mov cx, 20
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 50
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix9
			mov bl, 004h
			mov cx, 18
			int 10h
			int 21h
			
			ret
france_flag	endp

;====================================RUSSIAN FLAG====================================
russia_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset average
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
				mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
				mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			ret
russia_flag	endp

;====================================DEUTSCH FLAG====================================
nether_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset average
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 001h
			mov cx, 56
			int 10h
			int 21h
			
			ret
nether_flag	endp

;====================================POLISH FLAG====================================
poland_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset average
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			ret
poland_flag	endp

;==================================INDONESIAN FLAG===================================
indo_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset average
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 004h
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 12
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix28
			mov bl, 00Fh
			mov cx, 56
			int 10h
			int 21h
			
			ret
indo_flag	endp

;===================================NORWEGIAN FLAG===================================
norway_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset hard
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 001h
			mov cx, 4
			int 10h
			int 21h
			
			ret
norway_flag	endp

;====================================ICELAND FLAG====================================
icelnd_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset hard
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 28
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix4
			mov bl, 00Fh
			mov cx, 8
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 004h
			mov cx, 4
			int 10h
			int 21h
			
			ret
icelnd_flag	endp

;====================================SWEDISH FLAG====================================
sweden_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset hard
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Eh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Eh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Eh
			mov cx, 4
			int 10h
			int 21h
			
			ret
sweden_flag	endp

;===================================FINNISH FLAG===================================
finlnd_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset hard
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 001h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix3
			mov bl, 001h
			mov cx, 6
			int 10h
			int 21h
			
			ret
finlnd_flag	endp

;====================================DANISH FLAG====================================
denmrk_flag	proc near
			mov ax, 3
			int 10h
			
			mov ah, 2
			mov dl, 12
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset hard
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 59
			mov dh, 1
			int 10h

			mov ah, 9
			mov dx, offset counter
			mov bl, 00Fh
			mov cx, 7
			int 10h
			int 21h

			mov ah, 2
			mov dl, 18
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 3
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 4
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 5
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 6
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 7
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 8
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 9
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 10
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 00Fh
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 11
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 12
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 13
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 14
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 15
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 16
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 18
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix22
			mov bl, 004h
			mov cx, 44
			int 10h
			int 21h
			
			mov ah, 2
			mov dl, 30
			mov dh, 17
			int 10h

			mov ah, 9
			mov dx, offset pix2
			mov bl, 00Fh
			mov cx, 4
			int 10h
			int 21h
			
			ret
denmrk_flag	endp

end game