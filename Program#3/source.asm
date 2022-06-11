; Author: Michael Smith
; OSU email address: smitmic5@oregonstate.edu
; Course number/section: CS271
; Assignment Number: Program 3     Due Date: 01/30/22
; Description: This program is called the Integer Accumulator.
; It asks for the users name and then has them input however many
; numbers they like between the range of -100 and -1. Then it calculates
; the sum and average of all the numbers inputed and then displays them
; to the user.

INCLUDE Irvine32.inc

; constant definitions for upper and lower limits
LOWER_LIMIT EQU <-100>
UPPER_LIMIT EQU <-1>

.data
 
; variable definitions
intro_1   BYTE  "Welcome to the Integer Accumulator by Michael Smith",0
intro_2   BYTE  "Hello, ",0
prompt_1  BYTE  "What's your name? ",0
prompt_2  BYTE  "Enter number: ",0
instr_1   BYTE  "Please enter numbers in [-100, -1].",0
instr_2   BYTE  "Enter a non-negative number when you are finished to see results.",0
valid_1   BYTE  "Invalid number, please enter numbers in [-100, -1].",0
valid_2   BYTE  "You entered ",0
valid_3   BYTE  " valid numbers.",0
result_1  BYTE  "The sum of your valid numbers is ",0
result_2  BYTE  "The rounded average is ",0
goodbye_1 BYTE  "Thank you for playing Integer Accumulator!",0
goodbye_2 BYTE  "Goodbye, ",0
goodbye_3 BYTE  "No numbers entered. Bye, ",0
userName  BYTE  33 DUP(0) ;string to be entered by the user
userInput SDWORD  ?     ;signed integer, within the range, to be entered
count   DWORD 0     ;counts number of valid integers entered
accumulator SDWORD  0     ;signed integer that will sum all the integers entered
average   SDWORD  ?
remainder SDWORD  ?    

.code
main PROC

;Display program title and programmer's name
  mov   edx, OFFSET intro_1
  call  WriteString      
  call  CrLf          

;Get user name
  mov   edx, OFFSET prompt_1  
  call  WriteString
  mov   edx, OFFSET username  
  mov   ecx, 32
  call  ReadString      

;Display introduction
  mov   edx, OFFSET intro_2
  call  WriteString
  mov   edx, OFFSET userName
  call  WriteString
  call  CrLf

;Display instructions
  mov   edx, OFFSET instr_1
  call  WriteString
  call  CrLf
  mov   edx, OFFSET instr_2
  call  WriteString
  call  CrLf

;Get valid user inputs loop
getInputs:        
  mov   edx, OFFSET prompt_2
  call  WriteString  
  call  ReadInt

  ;compund condition (AND): (1)input is greater than lower limit AND (2)input is less than upper limit
  mov   userInput, eax      ;store input into userInput
  cmp   eax, LOWER_LIMIT    ;check condition 1
  jl    falseBlock1       ;userInput < LOWER_LIMIT  
  cmp   eax, UPPER_LIMIT    ;check condition 2
  jg    falseBlock2       ;userInput > UPPER_LIMIT  
   
;trueBlock, update accumulator
  mov   eax, userInput      
  add   eax, accumulator    ;add the accumulator to the userInput
  mov   accumulator, eax    ;mov the result back into the accumulator
  add   count, 1        ;increment count
  jmp   getInputs       ;get another input

falseBlock1:
  mov   edx, OFFSET valid_1  
  call  WriteString
  call CrLf
  jmp   getInputs

falseBlock2:
  cmp   count, 0        ;check count value
  jne   calculationBlock    ;jump to calculations block if there are numbers entered
  jmp   goodbyeBlock2     ;jump to goodbyeBlock2 if there are no numbers entered


calculationBlock:   ;calculate and display results
  ;display numbers entered
  mov   edx, OFFSET valid_2
  call  WriteString
  mov   eax, count        
  call  WriteDec        
  mov   edx, OFFSET valid_3
  call  WriteString
  call  CrLf

  ;display the sum of the numbers entered
  mov   edx, OFFSET result_1  
  call  WriteString
  mov   eax, accumulator
  call  WriteInt        
  call  CrLf

  ;calculate the rounded integer average
  mov   eax, accumulator
  cdq
  mov   ebx, count
  idiv  ebx        
  mov   average, eax

  ;check if rounding is needed
  mov   remainder, edx      ;double the remainder
  add   remainder, edx
  neg   remainder       ;reverses sign of remainder from (-) -> (+)
  cmp   remainder, ebx      ;compare the remainder with the divisor
  jl    displayAverage      ;remainderX2 < the divisor (count)
                 
roundUp:        ;if the remainderX2 is >= the divisor (count) then perform rounded average loop until there is no remainder
  dec   accumulator       ;add negative one the accumulator
  mov   eax, accumulator
  cdq
  mov   ebx, count
  idiv  ebx           ;signed division: quotient in eax, remainder in edx, count still in ebx
  mov   average, eax

  ;check if rounding is needed
  add   edx,edx         ;double the remainder
  mov   remainder, edx
  cmp   remainder, ebx      ;compare the remainder with the divisor (count in ebx)
  jge   roundUp         ;remainderX2 >= the divisor (count) execute roundUp block again

displayAverage:    
  mov   edx, OFFSET result_2
  call  WriteString
  mov   edx, OFFSET average
  call  Writeint
  call  CrLf
 
goodbyeBlock1:      
  call  CrLf
  mov   edx, OFFSET goodbye_1
  call  WriteString
  call  CrLf
  mov   edx, OFFSET goodbye_2
  call  WriteString
  mov   edx, OFFSET userName
  call  WriteString
  call  CrLf
  jmp   exitBlock

goodbyeBlock2:      ;output special goodbye with users name
  call  CrLf
  mov   edx, OFFSET goodbye_3 ;"No numbers entered. Bye, "
  call  WriteString
  mov   edx, OFFSET userName
  call  WriteString
  call  CrLf

exitBlock:      
 
    exit
main ENDP

END main
