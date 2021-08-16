#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################
defmodule LexerTest3 do

  use ExUnit.Case
  doctest LEX

  ##################################################### Third stage #####################################################

    #Tenemos que ir a LEX y buscamos la funcion lex que acabamos de decir como funciona esta funcion
    #Le digo verificame : Acaso estos tokens se encuentran ?
  test "35.-Operation add" do
    tlist=LEX.lexs("int main(){
      return 1+9;
    }")
     #assert nos devuelve algo si es verdadero
    assert tlist==[
      #Checamos que todo los toquens esten ,para que no haya errores en este ejemplo
      #Podemos ver Todos los tokens provenientes de LEX
      #Como no hay errores ,termino correctamente y va al parser
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1}, #El numero 1
      {:op, 2, [:add]},
      {:num, 2, 9}, #El numero 9
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "36.-Subtraction operation" do
    tlist=LEX.lexs("int main(){
      return 1-2;
    }")
    assert tlist== [
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:neg]},
      {:num, 2, 2},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

    test "37.-mul operation" do
      tlist=LEX.lexs("int main(){
        return 1*9;
      }")
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        {:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:num, 2, 1},
        {:op, 2, [:mul]},
        {:num, 2, 9},
        {:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
  end

  test "38.-Divisition operation" do
    tlist=LEX.lexs ("int main(){
      return 1/9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:div]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  ############################################## Errors ###################################################################
    #Aqui tenemos un ejemplo el cual no tiene el int
    #Por tanto al compilar este codigo nos mostrara un error
  test "39.-Operation add not int" do
    tlist=LEX.lexs(" main(){
      return 1+9;
    }")
    assert tlist==[
      #{:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:add]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "40.-Operation add not main" do
    tlist=LEX.lexs("int (){
      return 1+9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      #{:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:add]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "41.-Operation add not left parent" do
    tlist=LEX.lexs("int main){
      return 1+9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
     #{:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:add]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "42.-Operation add not rigt paren" do
    tlist=LEX.lexs("int main({
      return 1+9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      #{:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:add]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "43.-LOperation add Capital letters -RETURN-" do
    tlist = LEX.lexs("int main() {
      RETURN 1 + 9;
         }")

    assert tlist ==
             [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:string, 2, ["RETURN"]},
               {:num, 2, 1},
               {:op, 2, [:add]},
               {:num, 2, 9},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
  end

  test "44.-Operation add not not semicolon" do
    tlist=LEX.lexs("int main(){
      return 1+9
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:add]},
      {:num, 2, 9},
      #{:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "45.-Operation add not right brace" do
    tlist=LEX.lexs("int main(){
      return 1+9;
    ")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:add]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      #{:right_brace, 3, []}
    ]
  end

  test "46.-Operation add not operator" do
    tlist=LEX.lexs("int main(){
      return 1 9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      #{:op, 2, [:add]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "47.-Operation add not numbers" do
    tlist=LEX.lexs("int main(){
      return + ;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      #{:num, 2, 1},
      {:op, 2, [:add]},
      #{:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "48.-Operation add ,one number" do
    tlist=LEX.lexs("int main(){
      return 1 + ;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:add]},
      #{:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  ############################################# Erros neg ###################################################################

  test "49.-Subtraction operation not int" do
    tlist=LEX.lexs(" main(){
      return 1-2;
    }")
    assert tlist== [
      #{:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:neg]},
      {:num, 2, 2},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "50.-Subtraction operation not main" do
    tlist=LEX.lexs("int (){
      return 1-2;
    }")
    assert tlist== [
      {:type, 1, [:intKeyWord]},
      #{:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:neg]},
      {:num, 2, 2},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "51.-Subtraction operation not left paren" do
    tlist=LEX.lexs("int main ){
      return 1-2;
    }")
    assert tlist== [
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      #{:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:neg]},
      {:num, 2, 2},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "52.-Subtraction operation not right paren" do
    tlist=LEX.lexs("int main({
      return 1-2;
    }")
    assert tlist== [
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
     # {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:neg]},
      {:num, 2, 2},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "53.-Subtraction operation not left brace" do
    tlist=LEX.lexs("int main()
      return 1-2;
    }")
    assert tlist== [
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
     # {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:neg]},
      {:num, 2, 2},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "54.-Subtraction operation Capital letters -RETURN-" do
    tlist = LEX.lexs("int main() {
      RETURN 1 - 2;
         }")

    assert tlist ==
             [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:string, 2, ["RETURN"]},
               {:num, 2, 1},
               {:op, 2, [:neg]},
               {:num, 2, 2},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
  end

  test "55.-Subtraction operation not numbers" do
    tlist=LEX.lexs("int main(){
      return -;
    }")
    assert tlist== [
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      #{:num, 2, 1},
      {:op, 2, [:neg]},
      #{:num, 2, 2},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "56.-Subtraction operation not neg" do
    tlist=LEX.lexs("int main(){
      return 1 2;
    }")
    assert tlist== [
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      #{:op, 2, [:neg]},
      {:num, 2, 2},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "57.-Subtraction operation not semicolon" do
    tlist=LEX.lexs("int main(){
      return 1 - 2
    }")
    assert tlist== [
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:neg]},
      {:num, 2, 2},
      #{:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end
  ################################################ Error mul ################################################################
  test "58.-mul operation not int" do
    tlist=LEX.lexs(" main(){
      return 1*9;
    }")
    assert tlist==[
      #{:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:mul]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "59.-mul operation not main" do
    tlist=LEX.lexs("int (){
      return 1*9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      #{:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:mul]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
   end

   test "60.-mul operation not left paren" do
    tlist=LEX.lexs("int main){
      return 1*9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      #{:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:mul]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
    end

    test "61.-mul operation not right paren" do
      tlist=LEX.lexs("int main({
        return 1*9;
      }")
      assert tlist==[
        {:type, 1, [:intKeyWord]},
        {:ident, 1, [:mainKeyWord]},
        {:left_paren, 1, []},
        #{:right_paren, 1, []},
        {:left_brace, 1, []},
        {:ident, 2, [:returnKeyWord]},
        {:num, 2, 1},
        {:op, 2, [:mul]},
        {:num, 2, 9},
        {:semicolon, 2, []},
        {:right_brace, 3, []}
      ]
  end

  test "62.-mul operation not left brace" do
    tlist=LEX.lexs("int main()
      return 1*9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      #{:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:mul]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
end

test "63.-mul operation not numbers" do
  tlist=LEX.lexs("int main(){
    return * ;
  }")
  assert tlist==[
    {:type, 1, [:intKeyWord]},
    {:ident, 1, [:mainKeyWord]},
    {:left_paren, 1, []},
    {:right_paren, 1, []},
    {:left_brace, 1, []},
    {:ident, 2, [:returnKeyWord]},
   # {:num, 2, 1},
    {:op, 2, [:mul]},
    #{:num, 2, 9},
    {:semicolon, 2, []},
    {:right_brace, 3, []}
  ]
end

  test "64.-mul operation not operator" do
  tlist=LEX.lexs("int main(){
    return  1 9 ;
  }")
  assert tlist==[
    {:type, 1, [:intKeyWord]},
    {:ident, 1, [:mainKeyWord]},
    {:left_paren, 1, []},
    {:right_paren, 1, []},
    {:left_brace, 1, []},
    {:ident, 2, [:returnKeyWord]},
    {:num, 2, 1},
    #{:op, 2, [:mul]},
    {:num, 2, 9},
    {:semicolon, 2, []},
    {:right_brace, 3, []}
  ]
end

test "65.-mul operation Capital letters -RETURN-" do
  tlist = LEX.lexs("int main() {
    RETURN 1 * 9;
       }")

  assert tlist ==
           [
             {:type, 1, [:intKeyWord]},
             {:ident, 1, [:mainKeyWord]},
             {:left_paren, 1, []},
             {:right_paren, 1, []},
             {:left_brace, 1, []},
             {:string, 2, ["RETURN"]},
             {:num, 2, 1},
             {:op, 2, [:mul]},
             {:num, 2, 9},
             {:semicolon, 2, []},
             {:right_brace, 3, []}
           ]
  end

test "66.-mul operation not semicolon" do
  tlist=LEX.lexs("int main(){
    return 1*9
  }")
  assert tlist==[
    {:type, 1, [:intKeyWord]},
    {:ident, 1, [:mainKeyWord]},
    {:left_paren, 1, []},
    {:right_paren, 1, []},
    {:left_brace, 1, []},
    {:ident, 2, [:returnKeyWord]},
    {:num, 2, 1},
    {:op, 2, [:mul]},
    {:num, 2, 9},
    #{:semicolon, 2, []},
    {:right_brace, 3, []}
  ]
end

test "67.-mul operation not right brace" do
  tlist=LEX.lexs("int main(){
    return 1*9;
  ")
  assert tlist==[
    {:type, 1, [:intKeyWord]},
    {:ident, 1, [:mainKeyWord]},
    {:left_paren, 1, []},
    {:right_paren, 1, []},
    {:left_brace, 1, []},
    {:ident, 2, [:returnKeyWord]},
    {:num, 2, 1},
    {:op, 2, [:mul]},
    {:num, 2, 9},
    {:semicolon, 2, []},
    #{:right_brace, 3, []}
  ]
  end

  ##################################################### Error div #############################################################

  test "68.-Divisition operation not int" do
    tlist=LEX.lexs (" main(){
      return 1/9;
    }")
    assert tlist==[
     # {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:div]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "69.-Divisition operation not main" do
    tlist=LEX.lexs ("int (){
      return 1/9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      #{:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:div]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "70.-Divisition operation left paren" do
    tlist=LEX.lexs ("int main){
      return 1/9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      #{:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:div]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "71.-Divisition operation not right paren" do
    tlist=LEX.lexs ("int main({
      return 1/9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      #{:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:div]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "72.-Divisition operation not left brace" do
    tlist=LEX.lexs ("int main()
      return 1/9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
     #{:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:div]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "73.-Divisition operation not numbers" do
    tlist=LEX.lexs ("int main(){
      return /;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
     # {:num, 2, 1},
      {:op, 2, [:div]},
      #{:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "74.-Divisition operation not operator" do
    tlist=LEX.lexs ("int main(){
      return 1 9;
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      #{:op, 2, [:div]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "75.-Divisition operation letters -RETURN-" do
    tlist = LEX.lexs("int main() {
      RETURN 1 / 9;
         }")

    assert tlist ==
             [
               {:type, 1, [:intKeyWord]},
               {:ident, 1, [:mainKeyWord]},
               {:left_paren, 1, []},
               {:right_paren, 1, []},
               {:left_brace, 1, []},
               {:string, 2, ["RETURN"]},
               {:num, 2, 1},
               {:op, 2, [:div]},
               {:num, 2, 9},
               {:semicolon, 2, []},
               {:right_brace, 3, []}
             ]
    end


  test "76.-Divisition operation not semicolon" do
    tlist=LEX.lexs ("int main(){
      return 1/9
    }")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:div]},
      {:num, 2, 9},
      #{:semicolon, 2, []},
      {:right_brace, 3, []}
    ]
  end

  test "77.-Divisition operation not right brace" do
    tlist=LEX.lexs ("int main(){
      return 1/9;
    ")
    assert tlist==[
      {:type, 1, [:intKeyWord]},
      {:ident, 1, [:mainKeyWord]},
      {:left_paren, 1, []},
      {:right_paren, 1, []},
      {:left_brace, 1, []},
      {:ident, 2, [:returnKeyWord]},
      {:num, 2, 1},
      {:op, 2, [:div]},
      {:num, 2, 9},
      {:semicolon, 2, []},
      #{:right_brace, 3, []}
    ]
  end

end
