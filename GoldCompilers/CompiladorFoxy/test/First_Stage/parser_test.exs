
#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

defmodule PAERSERTest do
  use ExUnit.Case
  doctest PAR
#################################################### Primera entrega ###########################################

  test "1.-Test_to_pass" do
    ast= LEX.lexs("int main() {
    return 2;
    }
    ")
    #assert si es verdadero
    #Nos acordamos que PAR llama a pars_prog ( el codigo que explcamos hace poco )
    #lf_node = Es nuestro nodo izquierdo
    #rt_node es nuestro nodo izquierdo
    assert PAR.pars_prog(ast) ==
      %AST{lf_node:
        %AST{lf_node:
          %AST{lf_node:
            %AST{lf_node: nil,
              #Hay que acordarse que cada cuando llegamos aqui se parte el codigo de acuerdo
              #A la explicacion del Parser que se ha comentado previamente
              node_name: :constant,
              rt_node: nil,
              val: 2},
            node_name: :return,
            rt_node: nil,
            val: :return},
        node_name: :function,
        rt_node: nil,
        val: :main},
      node_name: :program,
      rt_node: nil,
      val: nil}
  end
  #En este caso hay error
  test "2.-Capital letters -RETURN-" do
    #Llamamos al LEX y en la funcion lex que explicamos ,checamos los toquens
    ast= LEX.lexs("int main() {
    RETURN 2;
    }")
    #Por lo cual el assert nos dira que pasa, regresamos PAR  y buscamos
    #pars_prog ,lo cual nos mandara el error
    assert PAR.pars_prog(ast) == {:error, "I have found an error at 2: RETURN WRONG"}

  end
  #En este caso hay error
  test "3.-A parenthesis is missing" do
    ast= LEX.lexs("int main( {
    return 2;
    }")
    assert PAR.pars_prog(ast) ==  {:error, "I have found an error at 1: The closing parenthesis is missing "}

  end

 #En este caso hay error
  test "4.-There is no val in the return" do
    ast= LEX.lexs("int main() {
    return ;
    }")
    assert PAR.pars_prog(ast) ==  {:error, "I have found an error at 2: An integer val is expected"}
  end
 #En este caso hay error
  test "5.-No spaces" do
    ast= LEX.lexs("int main() {
    return2;
    }")
    assert PAR.pars_prog(ast) == {:error, "I have found an error at 2: RETURN WRONG"}
  end

  test "6.-Space" do
    ast= LEX.lexs("int main ()
    {
      return 2;
    }")
    assert PAR.pars_prog(ast) ==
    %AST{lf_node:
      %AST{lf_node:
        %AST{lf_node:
          %AST{lf_node: nil,
            node_name: :constant,
            #Hay que acordarse que cada cuando llegamos aqui se parte el codigo de acuerdo
            #A la explicacion del Parser que se ha comentado previamente
            rt_node: nil,
            val: 2},
          node_name: :return,
          rt_node: nil,
          val: :return},
        node_name: :function,
        rt_node: nil,
        val: :main},
      node_name: :program,
      rt_node: nil,
      val: nil}
  end

  test "7.-A Brace opens is missing" do
    ast= LEX.lexs("int main()  return 2;}")
    assert PAR.pars_prog(ast) == {:error, "I have found an error at 1: The Brace that opens is missing "}
  end



  test "8.-There is not semicolon" do
    ast= LEX.lexs("int main() { return 2 }")
    assert PAR.pars_prog(ast) == {:error, "I have found an error at 1: There is not semicolon "}
  end

  test "9.-One line everything" do
    ast= LEX.lexs("int main(){return 2;}")
    assert PAR.pars_prog(ast) ==
    %AST{lf_node:
      %AST{lf_node:
        %AST{lf_node:
          %AST{lf_node: nil,
            node_name: :constant,
            #Hay que acordarse que cada cuando llegamos aqui se parte el codigo de acuerdo
            #A la explicacion del Parser que se ha comentado previamente
            rt_node: nil,
            val: 2},
          node_name: :return,
          rt_node: nil,
          val: :return},
        node_name: :function,
        rt_node: nil,
        val: :main},
      node_name: :program,
      rt_node: nil,
      val: nil}
  end

  test "10.-Return  100" do
    ast= LEX.lexs("int main() {
    return 100;
    }")
    assert PAR.pars_prog(ast) ==
    %AST{
      lf_node:
        %AST{lf_node:
          %AST{lf_node:
            %AST{lf_node: nil,
              node_name: :constant,
              #Hay que acordarse que cada cuando llegamos aqui se parte el codigo de acuerdo
              #A la explicacion del Parser que se ha comentado previamente
              rt_node: nil,
              val: 100},
            node_name: :return,
          rt_node: nil,
          val: :return},
        node_name: :function,
        rt_node: nil,
        val: :main},
      node_name: :program,
      rt_node: nil,
      val: nil}
  end

  test "11.-Spaced" do
    ast= LEX.lexs("int   main    (  )  {   return  2 ; }")
    assert PAR.pars_prog(ast) ==
    %AST{lf_node:
      %AST{lf_node:
        %AST{lf_node:
          %AST{lf_node: nil,
            node_name: :constant,
            #Hay que acordarse que cada cuando llegamos aqui se parte el codigo de acuerdo
            #A la explicacion del Parser que se ha comentado previamente
            rt_node: nil,
            val: 2},
          node_name: :return,
          rt_node: nil,
          val: :return},
        node_name: :function,
        rt_node: nil,
        val: :main},
      node_name: :program,
      rt_node: nil,
      val: nil}
  end
end
