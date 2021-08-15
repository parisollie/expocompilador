#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

defmodule PAERSERTest3 do

  use ExUnit.Case
  doctest PAR

  #########################################################Tercera entrega#################################
#BINARIES

test "23.-Operation in parentheses" do
  ast= LEX.lexs("int main() {
    return ~(18 + 17);
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
              node_name: :binary,
              rt_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 17
              },
              val: :add
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

test "24.-Operation add" do
  ast= LEX.lexs("int main() {
    return ~7 + 7;
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
                val: 7
              },
              node_name: :binary,
              rt_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 7
              },
              val: :add
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

test "25.-Double subtraction" do
  ast= LEX.lexs("int main() {
    return 9- -2;
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
              val: 9
            },
            node_name: :binary,
            rt_node: %AST{
              lf_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 2
              },
              node_name: :unary,
              rt_node: nil,
              val: :neg
            },
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

test "26.-Subtraction" do
  ast= LEX.lexs("int main() {
    return 18 - 2;
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
            node_name: :binary,
            rt_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 2
            },
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

test "27.-add and mul" do
  ast= LEX.lexs("int main() {
    return 9 + 8 * 7;
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
              val: 9
            },
            node_name: :binary,
            rt_node: %AST{
              lf_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 8
              },
              node_name: :binary,
              rt_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 7
              },
              val: :mul
            },
            val: :add
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

test "28.-Operation with parentheses and mul" do
  ast= LEX.lexs("int main() {
    return 2 * (8 + 4);
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
              val: 2
            },
            node_name: :binary,
            rt_node: %AST{
              lf_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 8
              },
              node_name: :binary,
              rt_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 4
              },
              val: :add
            },
            val: :mul
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

test "29.-mul" do
  ast= LEX.lexs("int main() {
    return 9 * 9;
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
              val: 9
            },
            node_name: :binary,
            rt_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 9
            },
            val: :mul
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


test "30.-Divition" do
  ast= LEX.lexs("int main() {
    return 4 / 2;
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
              val: 4
            },
            node_name: :binary,
            rt_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 2
            },
            val: :div
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

test "31.Divition denied" do
  ast= LEX.lexs("  int main() {
    return (-18) / 5;
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
            node_name: :binary,
            rt_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 5
            },
            val: :div
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

test "32.-Divition by 3" do
  ast= LEX.lexs("int main() {
    return 18 / 13 / 2;
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
            node_name: :binary,
            rt_node: %AST{
              lf_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 13
              },
              node_name: :binary,
              rt_node: %AST{
                lf_node: nil,
                node_name: :constant,
                rt_node: nil,
                val: 2
              },
              val: :div
            },
            val: :div
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

test "33.-Adittion" do
  ast= LEX.lexs("int main() {
    return 2 + 2;
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
              val: 2
            },
            node_name: :binary,
            rt_node: %AST{
              lf_node: nil,
              node_name: :constant,
              rt_node: nil,
              val: 2
            },
            val: :add
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
#############################################Invalids###############################################################

test "34.-There is not semicolon at mul" do
  ast= LEX.lexs("int main() {
    return 2*8
  }")

  assert PAR.pars_prog(ast) ==
    {:error,
    "I have found an error at 3: There is not semicolon "}
end

test "35.-There is not a second op" do
  ast= LEX.lexs("int main() {
    return 7 + ;
  }")
  assert PAR.pars_prog(ast) ==
    {:error, "I have found an error at 2: An integer val is expected"}
end

test "36.-There is not a first op at divition" do
  ast= LEX.lexs("int main() {
    return /3;
  }")
  assert PAR.pars_prog(ast) ==
    {:error, "I have found an error at 2: There is not a first op at divition"}
end

test "37.-There is a space between parentehis" do
  ast= LEX.lexs("int main( {
    return 9 (- 4);
  }")
  assert PAR.pars_prog(ast) ==
    {:error,
      "I have found an error at 1: The closing parenthesis is missing "}
end

end
