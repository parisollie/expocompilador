# expocompilador
* ** *****************************************************************************************************************************************
* 3-stage compiler, based on Nora Sandler's paper.

* Authors:  Paul Jaime Félix Flores & García Felipe Miguel & San Juan Aldape Diana Paola

* Date:    13/08/2021

* Our product requires users with experience in at least the language of c programming and use of the UNIX operating system
*You will be able to use the compiler foxy in a basic way with its minimum functions, for this you will need experience in basic use of both cases UNIX and C programming language.
*You will be able to make structural changes to improve the compiler code and use it to its fullest capacity, also requires basic knowledge of how compilers work, as well as the parts that compose it.


* ** *****************************************************************************************************************************************



This repository contains all the work done for the final project of the course.


Before executing anything please keep in mind that you're goint to need to install a few libraries and programs in order
to get the full experience. You're going to need software like VLC media player, GIT and a web browser so pleas keep that
in mind before trying the program.

Compiler for c According to what was discussed with the client, a compiler for C, which in this first version can compile a file that returns a single “integer” number.
Version 1:
* Our compiler must can return an integer, compiling simple fragment code.

Version 2:
* Our compiler must can return a result operated with unary operations like negate result, positive, bitwise, and logical negation.

Version 3:
* Our compiler must can operate a binary operation like sum, subtraction, multiplication and division.

According to what the client requires, we will make a compiler, to achieve the scope of the project we will create a compiler which is capable of compiling elements "Integer", unary operators, as well as operations between them.
To reach this proposed scope, we will base ourselves on the tutorial by “Nora Sandler”, until its fourth installment, which the client has provided us with.
We will also rely on several courses on how to use git, elixir programming and our knowledge in assembler.


Tutorial

*Windows 

1) Add the environment variables, install something that reads c language like code blocs and add it as an environment variable to the bi folder.
2) The gcc is the compiler, in my case it was code blocks and copy the bin path.

*Check in cmd
  gcc --version
  elixir --version

3)Add the foxy app environment variable.

4)It is compiled this way:

escript foxy -s codec_c/StageOne/Valid/05return_2.c
C:\Users\Henry\Desktop\CompiladorFoxy\codec_c\StageOne\Valid
05return_2.exe
echo %errorlevel%

escript foxy -s codec_c/StageTwo/Valid/13bitwise.c
C:\Users\Henry\Desktop\CompiladorFoxy\codec_c\StageTwo\Valid
13bitwise.exe
echo %errorlevel%

escript foxy -s codec_c/StageThree/Valid/24add.c
cd C:\Users\Henry\Desktop\CompiladorFoxy\codec_c\StageThree\Valid
24add.exe
echo %errorlevel%

5) Enjoy

