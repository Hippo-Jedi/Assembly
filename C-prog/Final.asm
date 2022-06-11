; Author: Michael Smith
; OSU email address: smitmic5@oregonstate.edu
; Course number/section: CS271
; Assignment Number: Final Project      Due Date: 03/15/22
; Description:

INCLUDE Irvine32.inc

.data
operand1   WORD    46
operand2   WORD    -20
greeting   BYTE  "Welcome James Taylor",0
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
  mov  ebx, [eax]

  cmp  ebx, 0
  jz   Decoy
  cmp  ebx, -1
  jz   Encrypt
  cmp  ebx, -2
  jz   Decrypt

  jmp  EndBlock

Decoy:
  call decoy_mode

Encrypt:
  push operand1
  push operand2
  push OFFSET dest
  call encrypt_mode

Decrypt:
  call decrypt_mode

EndBlock:
  pop ebp
  ret

compute ENDP

decoy_mode PROC
  push ebp
  mov  ebp, esp
  mov  eax, [ebp+12]
  add  eax, [ebp+10]
  mov  ebx, [ebp+8]
  mov  [ebx], eax

  pop  ebp
  ret  8
decoy_mode ENDP

encrypt_mode PROC
  push ebp
  mov  ebp, esp
  mov  eax, [ebp+12]
  sub  eax, [ebp+10]
  mov  ebx, [ebp+8]
  mov  [ebx], eax

  pop  ebp
  ret  8
encrypt_mode ENDP
  
decrypt_mode PROC
  mov  edx, OFFSET greeting
  call WriteString
decrypt_mode ENDP

END main