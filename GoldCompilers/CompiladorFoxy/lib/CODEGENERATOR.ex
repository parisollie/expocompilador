#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################
#( Miguel)


#Este es el tercer paso de nuestro compilador

#Esta integración nos permitirá establecer la siguiente funcionalidad básica:
#Tome el AST generado por el PARSER para construir el código en ensamblador, desde las hojas hasta la raíz.
#La salida será una cadena con el código representativo en ensamblador.

#****************************************************************************************
#Variables a saber

#EAX (Accumulator). Para operaciones aritm ́eticas
#ECX (Counter). Contador para bucles (como la variable ’i’ en C).
#EBX (Base). Puntero a datos o a primer elemento del vector (la base del vector).

#****************************************************************************************

defmodule CODEGENERATOR do
#################################################### Primera entrega #######################################

  # El generador de codigo navegara ,para que construya el codigo
  #en este caso la salida es: en lenguaje ensamblador
  #De esta manera el gcc tomara el ensamblador y entonces hara  el ejecutable
  #Eso depende de cada sistema operativo ,en nuestro caso funciona en Windows tanto como Linux de 64 bits
  #usamos el AT&T syntax

  def gnt_Code(ast) do
    #Le damos el algortimo post orden
    code = post_order(ast," ")
    code
  end

  def post_order(node, codeSnipped) do
    case node do
      #Si ya no hay mas nodos ahi termina
      nil ->
        ""

      ast_node ->
        #Si hay mas elementos ,partimos de la raiz del arbol y vamos bajando.
        if ast_node.node_name == :constant do
          emit_code(:constant, codeSnipped, ast_node.val)
        else

          emit_code(
            ast_node.node_name,
            #Pasamos a la parte izquierda
            post_order(ast_node.lf_node, codeSnipped) <>
            push_Up(ast_node) <>
            #pasamos al nodo derecho
            #Code snipped ,es el fragmento del codigo que le pasamos
            post_order(ast_node.rt_node, codeSnipped) <>
            pop_Up(ast_node),
            ast_node.val
            )

        end
    end
  end

  @spec emit_code(:constant | :function | :program | :return, any, any) :: <<_::8, _::_*8>>
  #Esta parte del codigo depende de que  version vamos a usar
  #En nuestro caso es un ensamblador de x64 bits en AT&t
  def emit_code(:program, codeSnipped, _) do
    """
    .section        __TEXT,__text,regular,pure_instructions
    .p2align        4, 0x90
    """ <>
      codeSnipped
  end
  #_main: ;Nuestra etiqueta para el comienzo de la funcion "main"
  #movl $2, %eax  ; Movl :Mueve la constante "2" dentro del  EAX register
  #esto es para nuestro primer ejemplo.
  def emit_code(:function, codeSnipped, :main) do
    """
    .globl  _main         ## -- Begin function main
    _main:                    ## @main
    """ <>
    #Le pegamos el pedazo del codigo, "<>" concatenar
      codeSnipped
  end
#ret ; Retornamos la funcion

  def emit_code(:return, codeSnipped, _) do
    codeSnipped <>
    """
      ret
    """
  end
  # EAX register contiene la (constante)
  #(% eax) es la ubicación de la memoria cuya dirección está contenida en el registro
  #movl:  Mueve el valor al EAX register
  def emit_code(:constant, _codeSnipped, val) do
    """
    movl    #{val}, %eax
    """
  end
######################################################## Segunda entrega ###################################
  def emit_code(:unary, codeSnipped, :neg) do
    #aqui EAX register contiene a la neg
    codeSnipped <>
      """
      neg    %eax
      """
  end
# cmpl $0: es como si dijeramos  a == 0 ? y lo movemos al eax register
 # movl   $0, %eax : Mueve la constante "0" dentro del  EAX register
 #sete al : nos muestra , cuále es el operando
  def emit_code(:unary, codeSnipped, :log_Neg) do
    codeSnipped <>
      """
      cmpl   $0, %eax
      movl   $0, %eax
      sete   %al
      """
  end
 #Ahora el rax contine al Bitewise complement eso significa el not
  def emit_code(:unary, codeSnipped, :bW) do
    codeSnipped <>
      """
      not    %rax
      """
  end
############################################################ Tercera entrega ###############################
#

    #Para manejar una expresión binaria, como: e1 + e2, nuestro ensamblador generado necesita:

   # Calcular e1 y debemos guardarlo en algún lugar de acuerdo al documento de Nora.
    #Calculamos  e2.
    #Anadir e1 a e2, y almacenar el resultado en EAX.

    #Entonces, necesitamos un lugar para guardar el primer operando.
    #Guardarlo en un registro sería complicado;
    #el segundo operando puede contener subexpresiones, por lo que también puede ser necesario guardar
    #los resultados intermedios en un registro
    #En su lugar, guardaremos el primer operando de la pila ,de acuerdo al documento de Nora.

    #******************************************************************************************

    #pop %rax : sacar el valor más alto de la pila al registro% rax
    #add (Agrega) : nos va  sumar  %rax con %rcx, osea e1 + e2

  def emit_code(:binary, codeSnipped, :add) do
    codeSnipped <>
      """
      pop     %rax
      add     %rax, %rcx
      """
  end
#sub: resta rax de rbx
#mueve %rbx dentro de rax
  def emit_code(:binary, codeSnipped, :neg) do
    codeSnipped <>
      """
      sub    %rax, %rbx
      mov    %rbx, %rax
      """
  end
#Multiplica registro por el registro 2
  def emit_code(:binary, codeSnipped, :mul) do
    codeSnipped <>
      """
      imul   %rbx, %rax
      """
  end
#para la divicion es mas complicada
#pus rax :save rax to the stack
#pop %rbx :empujar el valor de% rbx a la pila
#mueve %rbx dentro de rax
#idvq : Es el cociente almacenado en% rbx


  def emit_code(:binary, codeSnipped, :div) do
    codeSnipped <>
      """
      push   %rax
      mov    %rbx, %rax
      pop    %rbx
      cqo
      idivq  %rbx
      """
  end
 #La dirección de la parte superior de la pila se almacena en el registro ESP, también conocido
  #como puntero de pila. Al igual que con la mayoría de las pilas, puede empujar cosas hacia arriba
  #o sacar cosas de la parte superior; x64 incluye pushe and  popinstrucciones para hacer precisamente eso.
  # aqui estan nuestras funciones pop and push.

  ##push rax guardar rax en la pila
  def push_Up(ast_node) do

      if ast_node.node_name == :unary and ast_node.val == :neg and ast_node.rt_node == nil do
        """
        _Neg
        """
      else
        """
        push    %rax
        """
      end
  end

  def pop_Up(ast_node) do
     #pop %rbx empujar el valor de% rbx a la pila
      if ast_node.node_name == :unary and ast_node.val == :neg and ast_node.rt_node == nil do
        ""
      else
        """
        pop    %rbx
        """
      end
  end
end
