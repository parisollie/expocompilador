.section        __TEXT,__text,regular,pure_instructions
.p2align        4, 0x90
.globl  _main         ## -- Begin function main
_main:                    ## @main
movl    2, %eax
push    %rax
pop    %rbx
  ret
push    %rax
pop    %rbx
push    %rax
pop    %rbx
