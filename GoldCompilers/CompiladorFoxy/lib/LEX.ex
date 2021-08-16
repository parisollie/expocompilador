
#l_c = lexicon es una variable

#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################
# Miguel

#Este es el primer paso de nuestro compilador

#EL lexer solo tiene la funcion de ver que los tokens, que estos tokens sean validos

#identificarlos ,etiquetarlos y colocarlos en un arreglo.

# Esta integración validará esto:

# Validara nuestra lista de tokens.
# La salida será una lista de tuplas de cadenas de átomos.
#Si hay un error, nos mostrará una lista de tuplas con el token, así como
#la columna y la fila incorrectas.

defmodule LEX do

  @spec lexer(any, any) :: [{any, any, list | integer}]
  def lexer(l_c, col_Num) do
    #Esta es la lista de tokens que usaremos las 3 entregas

    #Mostramos la lista de tokens:

    ############################# Primera entrega ##############################################################
    tokens = [
      {:type, :intKeyWord},#               int
      {:ident, :returnKeyWord},#           return
      {:ident, :mainKeyWord},#             main
      {:left_brace},#                      {
      {:right_brace},#                     }
      {:left_paren},#                      (
      {:right_paren},#                     )
      {:semicolon},#                       ;
      ############################# Segunda entrega ###########################################################
      {:op, :neg},#                        -
      {:op, :log_Neg},#                    !
      {:op, :bW},#                         ~
      ############################# Tercera entrega ###########################################################
      {:op, :add},#                        +
      {:op, :div},#                        /
      {:op, :mul},#                        *
    ]
    ##################################################### Primera entrega #######################################
    #Mapeamos nuestro kewyword list
    mapp_to_kw = fn a -> {tokenToStr(a), a} end
    #Enum.map : enumerame las key words  y hace el mapeo de las keyword list
    key_words=Enum.map(tokens,mapp_to_kw)

    ######Todos los espacios independiendo del numero consecuntivo de los espacios
    spaces = ~r(^[ \h]+)
     # \ n los saltos de línea
     # \ n - nueva línea, \ r - retorno del acarreo
    ######independientemente del numero consecutivo de nuevas lineas
    line_br = ~r(^[\r\n]\n*)

    #Todos los caracteres
    #\ son los delimitadores
    alph = ~r{(^[a-zA-Z]\w*)|(\|\|)}
    #Los numeros independientemente del total del numero consecutivo de enteros
    numbs = ~r(^[0-9]+)

    cond do
      l_c == "" -> # La flecha significa ,si se cumple esto ejecutame esto
        []
      #Regex mach? nos regresara un Boolean para saber si hacemos un match

      Regex.match?(spaces, l_c) ->
        #Encuentra un espacio y remplazalo con absolutamente nada
        lexer(Regex.replace(spaces, l_c, "", global: false), col_Num)

      Regex.match?(line_br, l_c) -> # line_br, new lines
        #Increase the column number
        lexer(Regex.replace(line_br, l_c, "", global: false), col_Num + 1)

      Regex.match?(numbs, l_c) ->
        #We convert to integer
        #Run-Ejecuta la expresión regular contra la cadena dada hasta la primera coincidencia.
        #Esta nos Devuelve una lista con todas las capturas o nula si no se produjo ninguna coincidencia.

        #a traves de to integer le paso el valor
        num = String.to_integer(List.first(Regex.run(numbs, l_c)))#Convertimos a entero
        [
             {:num, col_Num, num}
             | lexer(Regex.replace(numbs, l_c, "", global: false), col_Num)
        ]

      true ->
        #checkWW es el check key word list,con esto checamos  los tokens
        {result, tokenStr} = checkKW(l_c, key_words)
        cond do
          # Mostraremos la key word list si es que existe
          result ->
            case tokenStr do
              {str, {x, y}} ->
                #replace_leading:
                # Reemplaza todas las apariciones principales de coincidencia reemplazando la coincidencia
                # en la cadena.
                # Devuelve la cadena intacta si no hay ocurrencias.
                #Enparejamos la lista
                [{x, col_Num, [y]} | lexer(String.replace_leading(l_c, str, ""), col_Num)]
                  {str, {x}} ->
                    [
                     {x, col_Num, []}
                      | lexer(String.replace_leading(l_c, str, ""), col_Num)
                    ]
            end

          # If we don't find anything
          Regex.match?(alph, l_c) ->
            #Return the matches
            identify = List.first(Regex.run(alph, l_c, [{:capture, :first}]))
            #We pair the column and the matches
            token = {:string, col_Num, [identify]}
            #We take the token if we found it
            [token | lexer(Regex.replace(alph, l_c, "", global: false), col_Num)]
          true -> #de otra manera
            #if we don't find anything le concatenamos el error y la linea donde esta
            raise "---We found an error :/ in:  " <>"#{l_c}" <> "on the column line:  "
             <> "#{col_Num}"
        end
    end
  end

  ############################################### lexs ###################################################
  def lexs(l_c) do
    #If we find something strange, we will notify you that you found
    #Le damos exactamente la linea en cual esta el error
    col_Num = 1
    #Nos vamos al llamado de la funcion lexer
    lexer(l_c, col_Num)
  end
############################# Primera entrega #################################################################

#Token catalog
  @spec tokenToStr(
          {:left_brace}
          | {:left_paren}
          | {:right_brace}
          | {:right_paren}
          | {:semicolon}
          | {:ident, :mainKeyWord | :returnKeyWord}
          | {:number, any}
          | {:op, :add | :bW | :div | :log_Neg | :mul | :neg}
          | {:string, any}
          | {:type, :intKeyWord}
        ) :: any
  def tokenToStr(token) do
    #aqui relacionamos el token con su represantacion en string
    case token do
      {:number, number} ->
        #Devuelve un binario que corresponde a la representación de texto del entero en la base dada.
        #####Ejemplo si ponemeos eso en el iex
        #####Iex >Integer.to_string(123)
        #####"123"
        to_string(number)
      {:string, str} ->
        str
      {:type, :intKeyWord} ->
        "int " # is it an int
      {:ident, :returnKeyWord} ->
         "return " #  return
      {:ident, :mainKeyWord} ->
        "main" #  main
      ################################################ Segunda entrega #######################################
      #Unary type
      #:op significa el operando
      {:op, :neg} ->
        "-"
      {:op, :log_Neg} ->
        "!"
      {:op, :bW} ->
        "~"
      ################################################ Tercera entrega #######################################
      #Binary types
      {:op, :add} ->
        "+"
      {:op, :div} ->
         "/"
      {:op, :mul} ->
         "*"

      ################################################Default syntax##########################################

      #Todos deben llevar por defecto:

      {:left_brace} ->
         "{"
      {:right_brace} ->
         "}"
      {:left_paren} ->
         "("
      {:right_paren} ->
         ")"
      {:semicolon} ->
        ";"
    end
  end

  def checkKW(input, key_words) do
    Enum.reduce_while(key_words, {}, fn {key, val}, _ ->
      #we review the collections
      if !String.starts_with?(input, key) do
        #Cont,continua la iteracion
        {:cont, {false, {}}}
      else
        #:halt Detiene inmediatamente el sistema de ejecución de Erlang.
        {:halt, {true, {key, val}}}
      end
    end)
  end
  @type tokenStr :: {String.t(), tuple}
end
