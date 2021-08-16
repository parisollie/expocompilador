#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################
defmodule LexerTest2 do

  use ExUnit.Case
  doctest LEX

  ##################################################### Second stage #########################################################
  test "8.-Unary " do

    #Tenemos que ir a LEX y buscamos la funcion lex que acabamos de decir como funciona esta funcion
    #Le digo verificame : Acaso estos tokens se encuentran ?
    tlist = LEX.lexs("int main(){
          return -2;
        }")
  #assert nos devuelve algo si es verdadero
    assert tlist == [
             #Checamos que todo los toquens esten ,para que no haya errores en este ejemplo
             #Podemos ver Todos los tokens provenientes de LEX
             #Como no hay errores ,termino correctamente y va al parser
             {:type, 1, [:intKeyWord]},
             {:ident, 1, [:mainKeyWord]},
             {:left_paren, 1, []},
             {:right_paren, 1, []},
             {:left_brace, 1, []},
             {:ident, 2, [:returnKeyWord]},
             {:op, 2, [:neg]},
             {:num, 2, 2},
             {:semicolon, 2, []},
             {:right_brace, 3, []}
           ]
  end

  test "9.-Unary_bitw" do
    tlist = LEX.lexs("int main(){
          return ~2;
        }")

    assert tlist == [
             {:type, 1, [:intKeyWord]},
             {:ident, 1, [:mainKeyWord]},
             {:left_paren, 1, []},
             {:right_paren, 1, []},
             {:left_brace, 1, []},
             {:ident, 2, [:returnKeyWord]},
             {:op, 2, [:bW]},
             {:num, 2, 2},
             {:semicolon, 2, []},
             {:right_brace, 3, []}
           ]
  end

    test "10.-Logic denied" do
      tlist=LEX.lexs(
        "int main(){
          return ! 2;
        }"
      )
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        {:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:op, 2, [:log_Neg]},
        {:num, 2, 2},
        {:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
    end
    ############################################### Errors ##################################################################
    #Aqui tenemos un ejemplo el cual no tiene el main
    #Por tanto al compilar este codigo nos mostrara un error
    test "11.-Unary no  main" do
      tlist = LEX.lexs("int (){
            return -2;
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               #{:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:neg]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "12.-Unary no  int" do
      tlist = LEX.lexs("main (){
            return -2;
          }")

      assert tlist == [
               #{:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:neg]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "13.-Unary no  left parent" do
      tlist = LEX.lexs("int main ){
            return -2;
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               #{:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:neg]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "14.-Unary no  right parent" do
      tlist = LEX.lexs("int main ({
            return -2;
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               #{:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:neg]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "15.-Unary no  left brace" do
      tlist = LEX.lexs("int main ()
            return -2;
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               #{:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:neg]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "16.-Unary Capital letters -RETURN-" do
      tlist = LEX.lexs("int main() {
        RETURN -2;
           }")

      assert tlist ==
               [
                 {:type, 1, [:intKeyWord]},
                 {:ident, 1, [:mainKeyWord]},
                 {:left_paren, 1, []},
                 {:right_paren, 1, []},
                 {:left_brace, 1, []},
                 {:string, 2, ["RETURN"]},
                 {:op, 2, [:neg]},
                 {:num, 2, 2},
                 {:semicolon, 2, []},
                 {:right_brace, 3, []}
               ]
    end

    test "17.-Unary no  semicolon" do
      tlist = LEX.lexs("int main (){
            return -2
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:neg]},
               {:num, 2, 2},
               #{:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "18.-Unary no right brace" do
      tlist = LEX.lexs("int main (){
            return -2;
          ")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:neg]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               #{:right_brace, 3, []}
             ]
    end
    ################################################### Unary_btw #########################################################
    test "19.-Unary_bitw not int" do
      tlist = LEX.lexs(" main(){
            return ~2;
          }")

      assert tlist == [
               #{:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:bW]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "20.-Unary_bitw not main" do
      tlist = LEX.lexs(" int (){
            return ~2;
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               #{:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:bW]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "21.-Unary_bitw not left  paren" do
      tlist = LEX.lexs(" int main ){
            return ~2;
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               #{:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:bW]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "22.-Unary_bitw not right  paren" do
      tlist = LEX.lexs(" int main ({
            return ~2;
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               #{:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:bW]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "23.-Unary_bitw not left brace" do
      tlist = LEX.lexs(" int main ()
            return ~2;
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               #{:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:bW]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "24.-Unary  bitw Capital letters -RETURN-" do
      tlist = LEX.lexs("int main() {
        RETURN ~2;
           }")

      assert tlist ==
               [
                 {:type, 1, [:intKeyWord]},
                 {:ident, 1, [:mainKeyWord]},
                 {:left_paren, 1, []},
                 {:right_paren, 1, []},
                 {:left_brace, 1, []},
                 {:string, 2, ["RETURN"]},
                 {:op, 2, [:bW]},
                 {:num, 2, 2},
                 {:semicolon, 2, []},
                 {:right_brace, 3, []}
               ]
    end

    test "25.-Unary_bitw not semicolon" do
      tlist = LEX.lexs(" int main (){
            return ~2
          }")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:bW]},
               {:num, 2, 2},
               #{:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end

    test "26.-Unary_bitw not right brace" do
      tlist = LEX.lexs(" int main (){
            return ~2;
          ")

      assert tlist == [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:ident, 2, [:returnKeyWord]},
               {:op, 2, [:bW]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               #{:right_brace, 3, []}
             ]
    end
  ############################################################ Logic ##############################################################
    test "27.-Logic denied not int" do
      tlist=LEX.lexs(
        " main(){
          return ! 2;
        }"
      )
      assert tlist==[
        #{:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        {:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:op, 2, [:log_Neg]},
        {:num, 2, 2},
        {:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
    end

    test "28.-Logic denied not main" do
      tlist=LEX.lexs(
        "int (){
          return ! 2;
        }"
      )
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        #{:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        {:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:op, 2, [:log_Neg]},
        {:num, 2, 2},
        {:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
    end

    test "29.-Logic denied not left paren" do
      tlist=LEX.lexs(
        "int main ){
          return ! 2;
        }"
      )
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        #{:left_paren, 1, []},
        {:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:op, 2, [:log_Neg]},
        {:num, 2, 2},
        {:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
    end

    test "30.-Logic denied not right paren" do
      tlist=LEX.lexs(
        "int main({
          return ! 2;
        }"
      )
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        #{:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:op, 2, [:log_Neg]},
        {:num, 2, 2},
        {:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
    end

    test "31.-Logic denied not left brace" do
      tlist=LEX.lexs(
        "int main()
          return ! 2;
        }"
      )
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        {:right_paren, 1, []},
        #{:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:op, 2, [:log_Neg]},
        {:num, 2, 2},
        {:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
    end

    test "32.-Logic denied Capital letters -RETURN-" do
      tlist = LEX.lexs("int main() {
        RETURN ! 2;
           }")

      assert tlist ==
               [
                 {:type, 1, [:intKeyWord]},
                 {:ident, 1, [:mainKeyWord]},
                 {:left_paren, 1, []},
                 {:right_paren, 1, []},
                 {:left_brace, 1, []},
                 {:string, 2, ["RETURN"]},
                 {:op, 2, [:log_Neg]},
                 {:num, 2, 2},
                 {:semicolon, 2, []},
                 {:right_brace, 3, []}
               ]
    end

    test "33.-Logic denied not semicolon" do
      tlist=LEX.lexs(
        "int main(){
          return ! 2
        }"
      )
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        {:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:op, 2, [:log_Neg]},
        {:num, 2, 2},
        #{:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
    end

    test "34.-Logic denied not rigt brace" do
      tlist=LEX.lexs(
        "int main(){
          return ! 2;
        "
      )
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        {:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:op, 2, [:log_Neg]},
        {:num, 2, 2},
        {:semicolon, 2, []},
       # {:right_brace, 3, []}
      ]
    end

end
