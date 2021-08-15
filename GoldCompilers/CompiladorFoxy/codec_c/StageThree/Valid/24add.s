.section        __TEXT,__text,regular,pure_instructions
.p2align        4, 0x90
.globl  _main         ## -- Begin function main
_main:                    ## @main
movl    2, %eax
push    %rax
movl    2, %eax
pop    %rbx
pop     %rax
add     %rax, %rcx
push    %rax
pop    %rbx
  ret
push    %rax
pop    %rbx
push    %rax
pop    %rbx
