;Author: Michael Smith
;OSU email address: smitmic5@oregonstate.edu
;Course number/section: CS271
;Assignment Number: Program 4     Due Date: 02/13/22
;Description: This program prompts the user to input a number with the range of 1
;and 300. Then it will show the user all composit numbers for the user inputted number.

INCLUDE Irvine32.inc

LOWER_LIMIT EQU <1>		;LOWER_LIMIT = 1
UPPER_LIMIT EQU	<300> ;UPPER_LIMIT = 300

.data

intro_1		BYTE	"Welcome to the Composite Number Spreadsheet",0
intro_2		BYTE	"Programmed by Michael Smith",0
intro_3		BYTE	"This program is capable of gernerating a list of composite numbers.",0
intro_4   BYTE  "Simply let me know how many you would like to see.",0
intro_5   BYTE  "I'll accept orders for up to 300 composites."
prompt_1	BYTE	"How many composites do you want to view? [1 .. 300]: ",0
valid_1		BYTE	"Out of range. Please try again.",0
spaces		BYTE	"   ",0
goodbye_1	BYTE	"Thanks for using my program!",0

number		DWORD	?		;user input for number of composite numbers to show
divisor		DWORD	1		;use with isComposite
dividend	DWORD	3		;use with isComposite
composite	DWORD	?		;will be used as a bool
;composite	DWORD	0		;Composite number to some nth degree
lineCount	DWORD	0		;keeps track of terms per line


.code
main PROC
	call	introduction
	call	getUserData
	call	validate
	call	showComposites
	;isComposite
	call	farewell

	exit	; exit to operating system
main ENDP


;Procedure to display instructions
;returns: console output 

introduction	PROC

;Display program title
	mov		edx, OFFSET intro_1		
	call	WriteString				
	call	CrLf					
;Display instructions
	mov		edx, OFFSET intro_2		
	call	WriteString				
	call	CrLf
	mov		edx, OFFSET intro_3		
	call	WriteString				
	call	CrLf	
	mov   edx, OFFSET intro_4
	call  WriteString
	call	CrLf
	mov   edx, OFFSET intro_5
	call  WriteString
	call  CrLf			
	
	ret
introduction	ENDP

;Procedure to get user input
;returns: number of composites to show in eax
;registers changed: eax
getUserData		PROC
	
	;get an integer for number
	mov		edx, OFFSET prompt_1
	call	WriteString
	call	ReadInt
	mov		number, eax

	;call validate to check input

	ret
getUserData		ENDP


;Procedure to validate user input is in range
;receives: number of composites to show
;returns: calls getUserData/none
;registers changed: eax

validate		PROC 

validationLoop:						;beginning of data post-test validation loop

	;compound condition (AND): (1)input greater than lower limit AND (1)less than upper limit
	cmp		eax, LOWER_LIMIT		;check condition 1 (number should still be in eax)
	jl		falseBlock				;number < LOWER_LIMIT
	cmp		eax, UPPER_LIMIT		;check condition 2
	jg		falseBlock				;number > UPPER_LIMIT

;trueBlock
	jmp		endBlock

falseBlock:
	mov		edx, OFFSET valid_1
	call	WriteString
	call	CrLf
	
	;Get another input and repeat validation 	
	call	getUserData				
	jmp		validationLoop

endBlock:
	ret
validate		ENDP


;Procedure to display composite numbers
;receives: number of composites to show is global variable
;returns: calls isComposite and outputs composites/nothing
;preconditions: number of composites to show set
;registers changed: eax, ebx, ecx

showComposites	PROC

	;set composite output loop counter
	mov		ecx, number

	;beginning of loop
	compositeLoop:
	;update dividend to parse
	inc		dividend
	mov		divisor, 2
	
	callComposite:
	;composite search
	mov		eax, dividend
	cdq
	mov		ebx, divisor
	div		ebx

	;call isComposit
	call	isComposite

	;check if isComposite returned true
	cmp		composite, 0
	jne		printComposite

	;composite not found so increment divisor until dividend - 1
	inc		divisor
	mov		edx, divisor
	cmp		edx, dividend
	jl		callComposite 
	jmp		compositeLoop
	
printComposite:
	;print composite to screen
	mov		eax, dividend
	mov		edx, OFFSET dividend
	call	WriteDec
	mov		edx, OFFSET spaces
	call	WriteString	
		
	inc		lineCount
	cmp		lineCount, 10
	je		newLine
	jmp		resume

newLine:
	call	CrLf
	mov		lineCount, 0			;reset

resume:
	loop	compositeLoop

	ret
showComposites	ENDP


;Procedure to determine composite numbers, checks remainder from the
;division search process. If remainder is 0, dividend is composite
;and iscomposite set to 1 for true else 0 for false
;receives: dividend and remainder from div in edx
;returns: composite as either 0, 1
;preconditions:	dividend is correct and divisor is in ebx

isComposite		PROC
	
	;check if remainder is zero
	cmp		edx, 0
	jne		notComposite

	;else dividend is composite
	mov		composite, 1
	jmp		endBlock2

notComposite:
	;set composite to false
	mov		composite, 0

endBlock2:
	ret
isComposite		ENDP

;Procedure to display the goodbye message
;returns: console output 

farewell		PROC
	
;Display goodbye message to the user
	call	CrLf
	mov		edx, OFFSET	goodbye_1
	call	WriteString
	call	CrLf

	ret
farewell		ENDP


END main