.section        __TEXT,__text,regular,pure_instructions
.p2align        4, 0x90
.globl  _main         ## -- Begin function main
_main:                    ## @main
movl    17, %eax
push    %rax
pop    %rbx
cmpl   $0, %eax
movl   $0, %eax
sete   %al
push    %rax
pop    %rbx
  ret
push    %rax
pop    %rbx
push    %rax
pop    %rbx
