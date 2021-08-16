#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

defmodule PAERSERTest2 do
  use ExUnit.Case
  doctest PAR

  ########################################################Segunda entrega #######################################
  test "12.-Bit wise" do
    ast= LEX.lexs("int main() {
    return ! 17;
    }")
    #assert si es verdadero
    #Nos acordamos que PAR llama a pars_prog ( el codigo que explcamos hace poco )
    #lf_node = Es nuestro nodo izquierdo
    #rt_node es nuestro nodo izquierdo
    assert PAR.pars_prog(ast) ==
    %AST{
      lf_node: %AST{
        lf_node: %AST{
          lf_node: %AST{
            lf_node: %AST{
              lf_node: nil,
               #Hay que acordarse que cada cuando llegamos aqui se parte el codigo de acuerdo
              #A la explicacion del Parser que se ha comentado previamente
              node_name: :constant,
              rt_node: nil,
              val: 17
            },
            node_name: :unary,
            rt_node: nil,
            val: :log_Neg
          },
          node_name: :return,
          rt_node: nil,
          val: :return
        },
        node_name: :function,
        rt_node: nil,
        val: :main
      },
      node_name: :program,
      rt_node: nil,
      val: nil
    }
  end

  test "13.-Bit wise 0" do
    ast= LEX.lexs("int main() {
      return ~0;
      }")
    assert PAR.pars_prog(ast) ==
    %AST{
      lf_node: %AST{
        lf_node: %AST{
          lf_node: %AST{
            lf_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 0
            },
            node_name: :unary,
            rt_node: nil,
            val: :bW
          },
          node_name: :return,
          rt_node: nil,
          val: :return
        },
        node_name: :function,
        rt_node: nil,
        val: :main
      },
      node_name: :program,
      rt_node: nil,
      val: nil
    }
  end

  test "14.-neg" do
    ast= LEX.lexs("int main() {
      return -18;
      }")
    assert PAR.pars_prog(ast) ==
    %AST{
      lf_node: %AST{
        lf_node: %AST{
          lf_node: %AST{
            lf_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 18
            },
            node_name: :unary,
            rt_node: nil,
            val: :neg
          },
          node_name: :return,
          rt_node: nil,
          val: :return
        },
        node_name: :function,
        rt_node: nil,
        val: :main
      },
      node_name: :program,
      rt_node: nil,
      val: nil
    }
  end

  test "15.-Nesting ops" do
    ast= LEX.lexs("int main() {
    return ! -18;
    }")

    assert PAR.pars_prog(ast) ==
    %AST{
      lf_node: %AST{
        lf_node: %AST{
          lf_node: %AST{
            lf_node: %AST{
              lf_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 18
              },
              node_name: :unary,
              rt_node: nil,
              val: :neg
            },
            node_name: :unary,
            rt_node: nil,
            val: :log_Neg
          },
          node_name: :return,
          rt_node: nil,
          val: :return
        },
        node_name: :function,
        rt_node: nil,
        val: :main
      },
      node_name: :program,
      rt_node: nil,
      val: nil
    }
  end

  test "16.-nesting not sence" do
    ast= LEX.lexs("int main() {
    return -~0;
    }")

    assert PAR.pars_prog(ast) ==
    %AST{
      lf_node: %AST{
        lf_node: %AST{
          lf_node: %AST{
            lf_node: %AST{
              lf_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 0
              },
              node_name: :unary,
              rt_node: nil,
              val: :bW
            },
            node_name: :unary,
            rt_node: nil,
            val: :neg
          },
          node_name: :return,
          rt_node: nil,
          val: :return
        },
        node_name: :function,
        rt_node: nil,
        val: :main
      },
      node_name: :program,
      rt_node: nil,
      val: nil
    }
  end

  test "17.-Not 18" do
    ast= LEX.lexs("int main() {
    return ! 18;
    }")

    assert PAR.pars_prog(ast) ==
    %AST{
      lf_node: %AST{
        lf_node: %AST{
          lf_node: %AST{
            lf_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 18
            },
            node_name: :unary,
            rt_node: nil,
            val: :log_Neg
          },
          node_name: :return,
          rt_node: nil,
          val: :return
        },
        node_name: :function,
        rt_node: nil,
        val: :main
      },
      node_name: :program,
      rt_node: nil,
      val: nil
    }
  end

  test "18.-Not 0" do
    ast= LEX.lexs("int main() {
    return ! 0;
    }")

    assert PAR.pars_prog(ast) ==
    %AST{
      lf_node: %AST{
        lf_node: %AST{
          lf_node: %AST{
            lf_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 0
            },
            node_name: :unary,
            rt_node: nil,
            val: :log_Neg
          },
          node_name: :return,
          rt_node: nil,
          val: :return
        },
        node_name: :function,
        rt_node: nil,
        val: :main
      },
      node_name: :program,
      rt_node: nil,
      val: nil
    }
  end


###################################### Invalidos ############################################################
 #En este caso hay error
test "19.-There is no return" do
  ast= LEX.lexs("int main() {
  return ! ;
  }")
  #Por lo cual el assert nos dira que pasa, regresamos PAR  y buscamos
    #pars_prog ,lo cual nos mandara el error
  assert PAR.pars_prog(ast) == {:error, "I have found an error at 2: An integer val is expected"}
end

test "20.-There is not semicolon" do
  ast= LEX.lexs("int main() {
  return ! 54
  }")
  assert PAR.pars_prog(ast) == {:error,
           "I have found an error at 3: There is not semicolon "}
end

test "21.-Nesting missing const" do
  ast= LEX.lexs("int main() {
  return ! ~;
  }")
  assert PAR.pars_prog(ast) ==  {:error, "I have found an error at 2: An integer val is expected"}
end


test "22.-There is wrong order" do
  ast= LEX.lexs("int main() {
  return 15-;
  }")

  assert PAR.pars_prog(ast) == {:error, "I have found an error at 2: An integer val is expected"}
end


end
