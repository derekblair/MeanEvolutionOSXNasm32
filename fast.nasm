


segment .text

global _update

_update:
  push ebx
  mov ebx,eax
  mov ecx,261116
  ulp:
  mov eax,[ebx+4*ecx]
  add eax,[ebx+4*ecx+4]
  add eax,[ebx+4*ecx+8]
  add eax,[ebx+4*ecx+4*512]
  add eax,[ebx+4*ecx+4*514]
  add eax,[ebx+4*ecx+4*1024]
  add eax,[ebx+4*ecx+4*1025]
  add eax,[ebx+4*ecx+4*1026]
  shr eax,3
  mov [edx+4*ecx+4*513],eax
  loop ulp  
  pop ebx
  ret 