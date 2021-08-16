#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

defmodule LEXERTest do
  use ExUnit.Case
  doctest LEX

  #We started doing our tests
#####################################################First stage ###########################################################

# Paul
#Nos Vamos al LEX y buscamos lexs,este nos dira los toquens que vamos a necesitar
  test "1.-Test_to_pass" do

    #Tenemos que ir a LEX y buscamos la funcion lex que acabamos de decir como funciona esta funcion
    #Le digo verificame : Acaso estos tokens se encuentran ?
    ast = LEX.lexs("int main() {
        return 2;
        }
        ")
    #assert nos devuelve algo si es verdadero
    assert ast == [
             #Checamos que todo los toquens esten ,para que no haya errores en este ejemplo
             #Podemos ver Todos los tokens provenientes de LEX
             #Como no hay errores ,termino correctamente y va al parser
             {:type, 1, [:intKeyWord]},
             {:ident, 1, [:mainKeyWord]},
             {:left_paren, 1, []},
             {:right_paren, 1, []},
             {:left_brace, 1, []},
             {:ident, 2, [:returnKeyWord]},
             {:num, 2, 2},
             {:semicolon, 2, []},
             {:right_brace, 3, []}
           ]
  end
  #Aqui tenemos un ejemplo el cual no tiene la llave que cierra
  #Por tanto al compilar este codigo nos mostrara un error
  test "2.-Not brace" do
    ast = LEX.lexs("int main() {
        return 0;

        ")

    assert ast == [
             {:type, 1, [:intKeyWord]},
             {:ident, 1, [:mainKeyWord]},
             {:left_paren, 1, []},
             {:right_paren, 1, []},
             {:left_brace, 1, []},
             {:ident, 2, [:returnKeyWord]},
             {:num, 2, 0},
             {:semicolon, 2, []}
             #{:right_brace, 3, []}  # Efectivamente este es el que falta

           ]
  end
  #Basicamente esto haremos en todas las entregas obvio solo quitaremos los tokens
  #para hacer las respectivas pruebas
  test "3.-No_Semicolon" do
    tlist = LEX.lexs("int main(){
      return 2
    }")

    assert tlist ==
             [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:num, 2, 2},
               {:right_brace, 3, []}
             ]
  end



  test "4.-No_Number" do
    tlist = LEX.lexs("int main(){
      return ;
    }")

    assert tlist ==
             [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
  end

  test "5.-Capital letters -RETURN-" do
    tlist = LEX.lexs("int main() {
      RETURN 0;
}")

    assert tlist ==
             [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:string, 2, ["RETURN"]},
               {:num, 2, 0},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
  end

  test "6.-Nonsense the return" do
    tlist = LEX.lexs("int main() {
                return rrr;
        }")

    assert tlist == [
             {:type, 1, [:intKeyWord]},
             {:ident, 1, [:mainKeyWord]},
             {:left_paren, 1, []},
             {:right_paren, 1, []},
             {:left_brace, 1, []},
             {:ident, 2, [:returnKeyWord]},
             {:string, 2, ["rrr"]},
             {:semicolon, 2, []},
             {:right_brace, 3, []}
           ]
  end

  test "7.- Something nonsensical" do
    tlist = LEX.lexs("a b c d e
        f g
        main ()
        h i return j
        k l m ;")

    assert tlist == [
             {:string, 1, ["a"]},
             {:string, 1, ["b"]},
             {:string, 1, ["c"]},
             {:string, 1, ["d"]},
             {:string, 1, ["e"]},
             {:string, 2, ["f"]},
             {:string, 2, ["g"]},
             {:ident, 3, [:mainKeyWord]},
             {:left_paren, 3, []},
             {:right_paren, 3, []},
             {:string, 4, ["h"]},
             {:string, 4, ["i"]},
             {:ident, 4, [:returnKeyWord]},
             {:string, 4, ["j"]},
             {:string, 5, ["k"]},
             {:string, 5, ["l"]},
             {:string, 5, ["m"]},
             {:semicolon, 5, []}
           ]
  end

end
