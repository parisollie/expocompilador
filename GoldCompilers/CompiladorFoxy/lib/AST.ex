#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#San Juan Aldape Diana Paola  (The System Integrator)

#Miguel

#El AST lo definimos como una estructura, le decimos la forma de la estructura:
#La estructura tienen un nombre, tienen un valor, un nodo derecho y un nodo izquierdo.
defmodule AST do
 defstruct [:node_name, :val, :lf_node, :rt_node]
end
