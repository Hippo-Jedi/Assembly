; EC:: Hello, Sadie Thomas
; Author: Michael Smith
; OSU email address: smitmic5@oregonstate.edu
; Course number/section: CS271
; Assignment Number: Final Project      Due Date: 03/15/22
; Description: This program is suppose to enter into one of three modes depending on what has been pushed
; onto the stack before the compute procedure is called. Decoy mode adds two and stores it onto the top of
; the stack, Encryption mode uses a substitution cipher to encrypt a message, and Decryption mode uses the 
; same cipher to decrypt a message.

INCLUDE Irvine32.inc

; Procedure enters into 1 or three modes depending on how its called
; receives: 3 stack parameters, WORD/BYTe, WORD/BYTE, OFFSET DWORD
; returns: Mode requested
; preconditions: The stack has three operands
compute  PROC
  push ebp      ;setup stack
  mov  ebp, esp
  mov  eax, [ebp+8]  ;store DWORD in eax
  mov  ebx, [eax]    ;dereference eax

  cmp  ebx, 0     ;compare ebx to 0
  jz   Decoy
  cmp  ebx, -1    ;compare ebx to -1
  jz   Encrypt
  cmp  ebx, -2    ;compare ebx to -2
  jz   Decrypt

  jmp  EndBlock

Decoy:
  mov  eax, [ebp+8]  
  mov  ebx, [ebp+10]
  mov  ecx, [ebp+12]
  push eax            ;push arguments as parameters
  push ebx
  push ecx
  call decoy_mode

Encrypt:
  mov  eax, [ebp+8]
  mov  ebx, [ebp+10]
  mov  ecx, [ebp+12]
  push eax            ;push arguments as parameters
  push ebx
  push ecx
  call encrypt_mode

Decrypt:
  mov  eax, [ebp+8]
  mov  ebx, [ebp+10]
  mov  ecx, [ebp+12]
  push eax            ;push arguments as parameters
  push ebx
  push ecx
  call decrypt_mode

EndBlock:
  pop ebp
  ret 12

compute ENDP

; Procedure to add two items on the stack and store the sum in dest
; receives: 3 stack parameters, WORD, WORD, OFFSET DWORD
; returns: Sum of the Two 16 bit operands inside the DWORD
; preconditions: Initial value of the offset DWORD is 0
decoy_mode PROC
  push ebp    ;set up stack
  mov  ebp, esp
  mov  eax, [ebp+12]  
  add  eax, [ebp+10]  ;add ebp+10 to eax
  mov  ebx, [ebp+8]   ;store sum in ebp+8
  mov  [ebx], eax

  pop  ebp
  ret  8 ;remove 8 extra bits
decoy_mode ENDP

; Procedure encrypt a msg using substitution cipher
; receives: 3 stack parameters, OFFSET BYTE, OFFSET BYTE, OFFSET DWORD
; returns: Encrypted plaintext OFFSET BYTE array
; preconditions: Initial value of the offset DWORD is -1
; This procedure is not done so there are not a lot of comments
encrypt_mode PROC
  push ebp
  mov  ebp, esp
  mov  eax, [ebp+12]
  push OFFSET eax 
  call STRLEN    ;get length of msg
next_char:
  cmp  [si], eax ;end of string
  jg   endLoop
  cmp  [si], ' '
  je   skip

  mov  al, [si]
  cmp  al, 'a'
  jb   skip
  cmp  al, 'z'
  ja   skip

  mov  [di], al
  inc  di

skip:
  inc  si 
  jmp  next_char

endLoop:
  inc  si
  mov  [si], eax

  ret
encrypt_mode ENDP
  
; Procedure decrypt a msg using substitution cipher
; receives: 3 stack parameters, OFFSET BYTE, OFFSET BYTE, OFFSET DWORD
; returns: Decrypted plaintext OFFSET BYTE array
; preconditions: Initial value of the offset DWORD is -2
; This procedure is not done so there are not a lot of comments
decrypt_mode PROC
  push ebp
  mov  ebp, esp
  mov  eax, [ebp+12]
  push OFFSET eax    ;get length of msg
  call STRLEN
next_char:
  cmp  [si], eax ;end of string
  jg   endLoop
  cmp  [si], ' '
  je   skip

nestedLoop:
  mov  eax, ecx
  add  eax, ebx
  mov  al, [si]
  cmp  al, [di]
  je   skip

  mov  [di], al
  inc  di

skip:
  inc  si 
  jmp  next_char

endLoop:
  inc  si
  mov  [si], eax

  pop  ebp
  ret  44

decrypt_mode ENDP

END main