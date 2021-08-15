#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

# Esta integración nos permitirá establecer la siguiente funcionalidad básica:
#Tome el AST generado por el Analizador para construir el código en ensamblador, desde las hojas hasta la raíz.
# La salida será una cadena con el código representativo en ensamblador.
#el recibe el arbol del parser
defmodule CODEGENERATOR do
#################################################### Primera entrega #######################################
  #The code generator receives the tree
  #osea recibe el AST
  # El generador de codigo navegara ,para que construya el codigo
  #en este caso la salida es, en lenguaje ensamblador
  #Para que asi el gcc tome el ensamblador y haga el ejecutable
  #Eso depende de cada sistema operativo en nuestro caso funcion en Windows como Ubuntu
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
        #Si hay mas elementos ,partimos de la raiz del arbol y bamos bajando.
        if ast_node.node_name == :constant do
          emit_code(:constant, codeSnipped, ast_node.val)
        else

          emit_code(
            ast_node.node_name,
            #Pasamos a la parte izquierda
            post_order(ast_node.lf_node, codeSnipped) <>
            push_Up(ast_node) <>
            #pasamos al nodo derecho
            #Code snipped es el fragmento del codigo que le pasamos
            post_order(ast_node.rt_node, codeSnipped) <>
            pop_Up(ast_node),
            ast_node.val
            )

        end
    end
  end

  @spec emit_code(:constant | :function | :program | :return, any, any) :: <<_::8, _::_*8>>
  #Depende es a la version es lo que va a pasar
  #En nuestro caso es un ensamblador de
  def emit_code(:program, codeSnipped, _) do
    """
    .section        __TEXT,__text,regular,pure_instructions
    .p2align        4, 0x90
    """ <>
      codeSnipped
  end

  def emit_code(:function, codeSnipped, :main) do
    """
    .globl  _main         ## -- Begin function main
    _main:                    ## @main
    """ <>
    #Le pegamos el pedazo del codigo, <> concatenar
      codeSnipped
  end
#_main:              ; etiqueta para el comienzo de la funcion "main"
#movl    $2, %eax    ; Mueve la constante "2" dentro del  EAX register
#ret                 ; Retornamos la funcion

  def emit_code(:return, codeSnipped, _) do
    codeSnipped <>
    """
      ret
    """
  end
  # EAX register contains (constante)
  #(% eax) es la ubicación de la memoria cuya dirección está contenida en el registro
  def emit_code(:constant, _codeSnipped, val) do
    """
    movl    #{val}, %eax
    """
  end
######################################################## Segunda entrega ###################################
  def emit_code(:unary, codeSnipped, :neg) do
    #now EAX register contains -(constante)
    codeSnipped <>
      """
      neg    %eax
      """
  end
  #instrucciones en ensamblador

 #cmpl es Una función con complejidad ciclomática superior a 10 se dividirá en múltiples subfunciones
 #para simplificar la lógica de la función.
 #  movl   $0, %eax Mueve la constante "0" dentro del  EAX register
 #sete al nos muestra , cuáles son los operandos, lo único importante
 #es el mnemónico.
  def emit_code(:unary, codeSnipped, :log_Neg) do
    codeSnipped <>
      """
      cmpl   $0, %eax
      movl   $0, %eax
      sete   %al
      """
  end
 #Ahora el rax contiene el simbolo not
  def emit_code(:unary, codeSnipped, :bW) do
    codeSnipped <>
      """
      not    %rax
      """
  end
############################################################ Tercera entrega ###############################
    #Para manejar una expresión binaria, como: e1 + e2, nuestro ensamblador generado necesita:

   # Calcular e1 y debemos guardardarlo en algún lugar de acuerdo al documento de Nora.
    #Calculamos  e2.
    #Anadir e1 a e2, y almacenar el resultado en EAX.

    #Entonces, necesitamos un lugar para guardar el primer operando.
    #Guardarlo en un registro sería complicado;
    #el segundo operando puede contener subexpresiones, por lo que también puede ser necesario guardar
     #los resultados intermedios en un registro
     #En su lugar, guardaremos el primer operando de la pila ,de acuerdo al documento de Nora.

    #Asi que de acuerdo al docmuento de Nora
    #<CODE FOR e1 >
    #push %rax ; guardar el valor de e1 en la pila
    #<CODE FOR e2 >
    #pop %rbx ; hacemos pop e1 desde el apilamiento  dentro ecx
    #addl %rbx, %eax ; add e1 to e2, save results in eax
  def emit_code(:binary, codeSnipped, :add) do
    codeSnipped <>
      """
      pop     %rax
      add     %rax, %rcx
      """
  end

  def emit_code(:binary, codeSnipped, :neg) do
    codeSnipped <>
      """
      sub    %rax, %rbx
      mov    %rbx, %rax
      """
  end

  def emit_code(:binary, codeSnipped, :mul) do
    codeSnipped <>
      """
      imul   %rbx, %rax
      """
  end

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
  #o sacar cosas de la parte superior; x86 incluye pushe and  popinstrucciones para hacer precisamente eso.


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

      if ast_node.node_name == :unary and ast_node.val == :neg and ast_node.rt_node == nil do
        ""
      else
        """
        pop    %rbx
        """
      end
  end
end
