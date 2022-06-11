; Author: Michael Smith
; OSU email address: smitmic5@oregonstate.edu
; Course number/section: CS271
; Assignment Number: Final Project      Due Date: 03/15/22
; Description:

INCLUDE Irvine32.inc

.data
operand1   WORD    46
operand2   WORD    -20
greeting  BYTE  "Welcome James Taylor",0
dest       DWORD   0
.code
;; inside the MAIN procedure
main  PROC
  push   operand1
  push   operand2
  push   OFFSET dest
  call   compute
;; currently dest holds a value of +26
  mov    eax, dest
  call   WriteInt   ; should display +26
main ENDP
compute  PROC
  push ebp
  mov  ebp, esp
  mov  eax, [ebp+8]
  cmp [ebp+8], 0
  jz decoy

  jmp endBlock

decoy:
  call decoy_mode

endBlock:
  ret
compute ENDP

;description
decoy_mode PROC
  mov edx, OFFSET greeting
  call WriteString
  call CrLf
decoy_mode ENDP


