; Author: Michael Smith
; OSU email address: smitmic5@oregonstate.edu
; Course number/section: CS271
; Assignment Number: Program 1       Due Date: 01/16/22
; Description: Program that asks user for two numbers and shows them the 
; sum, difference, quotient, and product. It also shows 
INCLUDE Irvine32.inc

.data
   assignment BYTE   "Program #1", 0
   programTitle BYTE   "Elementary Arithmetic by Michael Smith", 0
   instructions BYTE   "Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.", 0
   askNum1   BYTE   "First Number: ", 0
   askNum2   BYTE   "Second Number: ", 0
   number1   DWORD   ?   ; integer entered by user
   number2 DWORD   ?   ; second integer entered by user.
   goodByeMessage BYTE   "Impressed? Bye!",0.
   equalsString BYTE   " = ", 0
   sum   DWORD   ?
   sumString   BYTE   " + ",0
   difference   DWORD   ?
   differenceString   BYTE   " - ",0
   product DWORD   ?
   productString BYTE   " * ",0
   quotient   DWORD   ?
   quotientString BYTE   " / ",0
   remainder   DWORD   ?
   remainderString BYTE   " remainder ",0
   square1 DWORD ?
   square2 DWORD ?
   squareString BYTE "Square of ", 0
   errorMessage BYTE   "The second number must be less than the first", 0

.code
main PROC
   ;print the name
   mov   edx, OFFSET assignment
   call WriteString

   ;print the program title
   mov edx, OFFSET programTitle
   call WriteString
   call CrLf

   ;print the instructions
   mov edx, OFFSET instructions
   call   WriteString
   call   CrLf
   call   CrLf

   ;prompt the user to enter first number
   mov edx, OFFSET askNum1
   call WriteString
   ;read the first number
   call ReadInt
   mov number1, eax
   call CrLf

   ;prompt the user to enter second number
   mov edx, OFFSET askNum2
   call WriteString
   ;read the second number
   call ReadInt
   call CrLf
   mov number2, eax
   mov eax, number2
   ;compare the number
   ;if the second number is grater than first number
   ;then jump to Error loop else jump to Calculate
   cmp eax, number1
   jg Error
   jle Calculate

Error:
   ;print the error message
   mov edx, OFFSET errorMessage
   call WriteString
   call CrLf
   ;jump to endProgram
   jg endProgram

Calculate:
   ;move the values of number1 and number2
   ;into eax
   mov eax, number1
   add eax, number2
   mov   sum, eax

   ; find the difference
   mov eax, number1
   sub eax, number2
   mov difference, eax

   ; find the product
   mov eax, number1
   mov ebx, number2
   mul ebx
   mov product, eax

   ; find the quotient
   mov edx, 0
   mov eax, number1
   cdq
   mov ebx, number2
   cdq
   div ebx
   mov quotient, eax
   mov remainder, edx

   ; find the square
   mov eax, number1
   mov ebx, number1
   mul ebx
   mov square1, eax

   mov eax, number2
   mov ebx, number2
   mul ebx
   mov square2, eax

   ; print the sum Results
   mov eax, number1
   call WriteDec
   mov edx, OFFSET sumString
   call WriteString
   mov eax, number2
   call WriteDec
   mov edx, OFFSET equalsString
   call WriteString
   mov eax, sum
   call WriteDec
   call CrLf

   ;print the difference results
   mov eax, number1
   call WriteDec
   mov edx, OFFSET differenceString
   call WriteString
   mov eax, number2
   call WriteDec
   mov edx, OFFSET equalsString
   call WriteString
   mov eax, difference
   call WriteDec
   call CrLf

   ;print the product results
   mov eax, number1
   call WriteDec
   mov edx, OFFSET productString
   call WriteString
   mov eax, number2
   call WriteDec
   mov edx, OFFSET equalsString
   call WriteString
   mov eax, product
   call WriteDec
   call CrLf

   ;print the quotient results
   mov eax, number1
   call WriteDec
   mov edx, OFFSET quotientString
   call WriteString
   mov eax, number2
   call WriteDec
   mov edx, OFFSET equalsString
   call WriteString
   mov eax, quotient
   call WriteDec
   mov edx, OFFSET remainderString
   call WriteString
   mov eax, remainder
   call WriteDec
   call CrLf

   ; print square root
   mov edx, OFFSET squareString
   call WriteString
   mov eax, number1
   call WriteDec
   mov edx, OFFSET equalsString
   call WriteString
   mov eax, square1
   call WriteDec
   call CrLf

   mov edx, OFFSET squareString
   call WriteString
   mov eax, number2
   call WriteDec
   mov edx, OFFSET equalsString
   call WriteString
   mov eax, square2
   call WriteDec
   call CrLf
endProgram:
   ; prin the Goodbye
   call CrLf
   mov edx, OFFSET goodByeMessage
   call WriteString
   call CrLf

exit  
main ENDP
END main