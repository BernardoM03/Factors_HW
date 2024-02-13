; Author: Bernardo Mendes
; Last Modified: 2/1/24
; OSU email address: mendesb@oregonstate.edu
; Course number/section: CS 271-001
; Assignment Number:       2          Due Date: 2/1/24
; Description: Takes a min range and max range, displaying all factors/if its a prime number

INCLUDE Irvine32.inc

; (insert constant definitions here) 
LOWER_LIMIT = 1
UPPER_LIMIT = 1000

.data

; (insert variable definitions here)
	intro_1		BYTE		"This program calculates and displays the factors of numbers from lowerbound to upperbound.", 0
	intro_2		BYTE		"It also indicates when a number is a prime.", 0

	prompt_1	BYTE		"Enter your name: ", 0
	prompt_2	BYTE		"Enter a number between 1 and a 1000 for the lowerbound of the range: ", 0
	prompt_3	BYTE		"Enter a number between 1 and a 1000 for the upperbound of the range: ", 0
	prompt_4	BYTE		"Would you like to do another calculation? (0 = NO | 1 = YES)", 0

	result1		BYTE		": ", 0
	result2		BYTE		" ", 0
	result3		BYTE		" **Prime Number** ", 0

	lowerbound	DWORD		? 
	upperbound	DWORD		?
	good_bye	BYTE		"Good Bye ", 0
	username	BYTE		33 DUP(0)		;string enter by the user, initialized to 0 


.code
main PROC

; (insert executable instructions here)

; Introduce the programmer
	
	mov			edx, OFFSET intro_1
	call		WriteString
	call		Crlf
	mov			edx, OFFSET intro_2
	call		WriteString
	call		Crlf
	 

; Get the name from the user 
	mov			edx, OFFSET prompt_1
	call		WriteString

	mov			edx, OFFSET username
	mov			ecx, 32
	call		ReadString

start_program:

lower_bound: ; Get the lowerbound from the user
	mov			edx, OFFSET prompt_2
	call		WriteString
	call		ReadInt
	mov			lowerbound, eax
	cmp			lowerbound, LOWER_LIMIT
	jl			start_program

upper_bound: ; Get the upperbound from the user
	mov			edx, OFFSET prompt_3
	call		WriteString
	call		ReadInt
	mov			upperbound, eax
	cmp			upperbound, UPPER_LIMIT
	jg			upper_bound

 ; Do the Calculations
	
	mov			ecx, lowerbound ; keeps track of the lowerbound value, will be used to track current numbe

start_loop: ; first loop, prints current number that factors will be found of
	mov			esi, 0
	mov			ebx, 1
	mov			eax, ecx
    call		WriteDec 
	mov			edx, OFFSET result1
	call		WriteString
	jmp			factor_loop

 print_factor: ; When called, print the factor of the number and keep track of how many factors within ESI
	mov			eax, ebx
	call		WriteDec
	mov			edx, OFFSET result2
	call		WriteString
	inc			esi
	jmp			next_factor

 print_prime: ; If there are only two factors (1 and the number itself), print that it is a prime number
	cmp			esi, 2
	jne			decrement_loop
	mov			edx, OFFSET	result3
	call		WriteString
	jmp			decrement_loop

 factor_loop: ; Divides the current number by the changing divisor (ebx), If the remainder is 0, it is a factor
	mov			eax, ecx
	xor			edx, edx
	div			ebx
	cmp			edx, 0
	je			print_factor

 next_factor: ; Increase divisor by 1, and check if it is still less than the current number. If it is, restart the loop by the dividing (factor_loop)
	inc			ebx
	cmp			ebx, ecx
	jle			factor_loop
	jmp			print_prime

decrement_loop: ; Skips to new line and increments current number. If within lower/upper bound range, start the loop from the beginning.
	call		Crlf
	inc			ecx
    cmp			ecx, upperbound
    jle			start_loop


 input: ; Loop program from lower/upper bound input if desired
	mov			edx, OFFSET prompt_4
	call		WriteString
	call		ReadInt
	cmp			eax, 1
	je			start_program
	cmp			eax, 0
	je			end_program
	jmp			input


end_program: ; Ends program and says "Goodbye"
	mov		edx, OFFSET good_bye
	call		WriteString

	mov		edx, OFFSET username
	call		WriteString
	call		Crlf


	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
