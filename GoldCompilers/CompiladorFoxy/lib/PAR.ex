#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

#El parser verifica que la posicion ,el orden de los tokens sea el adecuado sea el PARSER

# Esta integración nos permitirá establecer la siguiente funcionalidad básica:
#Generara un AST con la lista de tuplas creada por Lexer.
#Si hay algún error, nos mostrará una lista de tuplas con el token que genera el error, la columna,
# y la fila.
#El analizador nos devuelve el AST, esto es porque tiene la sintaxis exacta, de lo contrario devuelve un error.

defmodule PAR do
#We get all the tokenlist, depende que etapa mandamos a llamar ,osea lo que nos da el LEXEr
#[int,main,(,),{,return,2,;,}]

#Parse program lo que hace es como un programa es equivalente a function
#Si nuestro compilador soportara el que nuestro programa tuviera mas funciones
#Dentro del program deberia haber un ciclo ,pero en este caso nada mas tenemos  una funcion
#en todo el proyecto,pues nada mas habra una funcion osea pars_func

#SI TODO ES EXITOSO NOS DARA LA FUNCION

  def pars_prog(tokenList) do #Le pasamos toda la lista de tokens

    testing = next(tokenList)
    #Erase the head
    token_list_final = List.delete_at(tokenList, 0)
    function = pars_func(testing, token_list_final)
    # En ese case validamos lo que paso
    case function do
      #We check the errors
      #Si hay errores nos manda una tupla ,con el mensaje de error
      {{:error, show_Message_Error}, token_list_final} ->
        {{:error, show_Message_Error}, token_list_final}
        {:error, show_Message_Error}
      #Our node function checks that there are no more elements in the tuple
      {function_node, token_list_final} ->
        if token_list_final == [] do#aqui preguntamos la lista de tokens,esta vacia ?

          #Add the root to the AST
          #Since everything is fine, the last node is added is that our root node
          #Wacth out!, the tree is added from the bottom up.
          #El AST se crea de abajo hacia arriba.
          #Finally we have the AST

          #Si todo es exitoso y parsea correctamente ,nos dara el nodo y el AST el resto de la lista
          #al final debe quedar vacia para que este bien  y devolvemos el AST
          #lf= left nodo
          #Le ponemos el nodo que se llama program le pegamos el nodo izquierdo ese nodo ya tiene
          #el return  y el valor de este
          %AST{node_name: :program, lf_node: function_node}
        else
          #Sino esta vacia ,mandamos el  error
          {:error, "Error: there are more elements after function end"}
        end
    end
  end

  @spec next(nonempty_maybe_improper_list) :: any
  def next(token_list_final) do
    #Take the next element
    first = Tuple.to_list(hd(token_list_final))
    #We get the keyword
    testing = List.first(first)
    #We cheek if is a identificator or a data type
    if testing == :ident || testing == :type do
      if testing == :num do
        List.last(first)
      else
        first = Tuple.to_list(hd(token_list_final))
        #We get the val (it cuould be "int" or "main")
        List.last(List.last(first))
      end
    else
      first = Tuple.to_list(hd(token_list_final))
      List.first(first)
    end
  end
  #To get the line
  def line(token_list_final) do
    #Give me the token list
    first = Tuple.to_list(hd(token_list_final))
    cola = tl(first)
    List.first(cola)
  end
############################################### Primera entrega #####################################
  #We review the matches
  #Take the list of tokens, I split it and I take the first one (next_Token)and I keep the
  #rest(token_list_final) and so on.
  #es una funcion recursiva ,asi hasta que generemos el AST
  def pars_func(next_Token, token_list_final) do
    #Aqui hay algo importante que debemos saber :
    #Nuestra funcion debe tener y deben estar en ese orden y existir !

    #int main() {
    # return 2;
    # }

    if next_Token == :intKeyWord #Si el token es el entero ,entonces continua sino mandamos los errores de abajo
    do
         next_Token = next(token_list_final)#next(token_list_final), asi los extraemos

        if next_Token == :mainKeyWord#si se cumple extraigo el siguiente que sera main
        do
            token_list_final = List.delete_at(token_list_final, 0)
            next_Token = next(token_list_final)

            if next_Token == :left_paren
            do
                token_list_final = List.delete_at(token_list_final, 0)
                next_Token = next(token_list_final)

                if next_Token == :right_paren
                do
                    token_list_final = List.delete_at(token_list_final, 0)
                    next_Token = next(token_list_final)

                    if next_Token == :left_brace
                    do
                        token_list_final = List.delete_at(token_list_final, 0)
                        next_Token = next(token_list_final)
                        #Si ya estoy aqui, aqui voy bien validando la sintaxis
                        #here he waits and goes to: parse_statment
                        statement = parse_statement(next_Token, token_list_final)

                        case statement
                        do
                          #Si parse statment me manda error ,le mando el error.
                            {{:error, show_Message_Error}, token_list_final}
                            ->
                                {{:error, show_Message_Error}, token_list_final}

                                {statement, token_list_final}
                                ->
                                    token_list_final = List.delete_at(token_list_final, 0)
                                    next_Token = next(token_list_final)
                                     #Si es exitoso le mando la lista ,para que cierre con (})
                                     if next_Token == :right_brace
                                     #After returning he gives us the other piece of the tree
                                     #Regresamos  donde dice : # Tenemos semicolon ?
                                     #Volvemos a donde fue llamado la primera vez
                                     do
                                          token_list_final = List.delete_at(token_list_final, 0)
                                          {%AST{node_name: :function, val: :main, lf_node: statement}, token_list_final}
                                     else
                                           #Si no encontramos la llave que cierra le mando eso
                                           line = line(token_list_final)
                                           {{:error, "I have found an error at #{line}: close brace missed "}, token_list_final}
                                     end

                        end

                    else
                        line = line(token_list_final)
                        {{:error, "I have found an error at #{line}: The Brace that opens is missing "}, token_list_final}
            end

              else
              line = line(token_list_final)
              {{:error, "I have found an error at #{line}: The closing parenthesis is missing "}, token_list_final}
            end
            else
              line = line(token_list_final)
              {{:error, "I have found an error at #{line}: open parentesis missed "}, token_list_final}
            end
    else
        line = line(token_list_final)
        {{:error, "I have found an error at #{line}: main function missed "}, token_list_final}
    end
    else
        line = line(token_list_final)
        {{:error, "I have found an error at #{line}: The return is in capital letters "}, token_list_final}
    end

  end
#Le digo  a Parse_statment y checa que si los tokens que te mando corresponden a un statment
#Parse statmen recibe [return,2,;}],porque son los tokens  que nos faltan
  def parse_statement(next_Token, token_list_final) do
    if next_Token == :returnKeyWord do #Checamos si esta la palabra return
      token_list_final = List.delete_at(token_list_final, 0)
      #It stays on hold and goes to :expression
      expression= parse_expression(token_list_final)
      #Nos vamos al case expresion
      case expression do
        {{:error, show_Message_Error}, token_list_final} ->
          #Si hay error lo mostramos
          {{:error, show_Message_Error}, token_list_final}
        #Si no hay error,saco el token de la lista y nos queda ;,}
        {expression, token_list_final} ->
          next_Token = next(token_list_final)

          if next_Token == :semicolon do # Tenemos semicolon ?
            # We return the node that is expression and return to where we are waiting the first time
            {%AST{node_name: :return, val: :return, lf_node: expression}, token_list_final}
          else
            line = line(token_list_final)
            {{:error, "I have found an error at #{line}: There is not semicolon "},
             token_list_final}
          end
      end

      else
      line = line(token_list_final)
      #Si no hay returno mandamos el error
      {{:error, "I have found an error at #{line}: RETURN WRONG"},
      token_list_final}

    end


  end



###################################### Segunda entrega ##############################################
#neg,bitewise and logic negated
def parse_unary(token_list_final) do
  next_Token = next(token_list_final) # Hacemos lo mismo que la primera ,partimos la lista de tokens y nos quedamos con los que siguen
  #to_list(enumerable)
  #Converts enumerable to a list.
  #hd(list). Returns the head of a list. Raises ArgumentError if the list is empty.
  first= Tuple.to_list(hd(token_list_final))
  #Retornams el ultimo elemento de la lista
  testing= List.last(first)

  case {next_Token, testing} do

    {:op, [:neg]} -> # Tenemos el toquen de negacion ? "-",:op = es el operadpr
      token_list_final= List.delete_at(token_list_final, 0)
      #Como ya tenemos el simbolo ,regresate ahora a encotar los demas tokens que faltan
      {tree, last} = parse_expression(token_list_final)

      case {tree, last} do
        {{:error, show_Message_Error}, token_list_final} ->
          {{:error, show_Message_Error}, token_list_final}
          #Mandamos el AST, si tenemos todo
        _ -> {%AST{node_name: :unary, val: :neg, lf_node: tree}, last}
      end

    {:op, [:log_Neg]} -> # Tenemos "!" ?
       token_list_final= List.delete_at(token_list_final, 0)
       #Como ya tenemos el simbolo ,regresate ahora a encotar los demas tokens que faltan
       {tree, last}= parse_expression(token_list_final)

      case {tree, last} do
        #En caso de error se lo mandamos
        {{:error,show_Message_Error}, token_list_final} ->
           {{:error,show_Message_Error}, token_list_final}
           #Mandamos el AST, si tenemos todo
        _ -> {%AST{node_name: :unary, val: :log_Neg, lf_node: tree}, last}
      end

    {:op, [:bW]} -> #Tenemos "~" ?
      token_list_final= List.delete_at(token_list_final, 0)
      #Como ya tenemos el simbolo ,regresate ahora a encotar los demas tokens que faltan
      {tree, last}= parse_expression(token_list_final)

      case {tree, last} do
        #En caso de error se lo mandamos
        {{:error, show_Message_Error}, token_list_final}
        ->
          {{:error, show_Message_Error}, token_list_final}
          #Mandamos el AST, si tenemos todo
        _ -> {%AST{node_name: :unary, val: :bW, lf_node: tree}, last}
      end
    _ ->
      line= line(token_list_final)
      {{:error, "I have found an error at #{line}: There is not a first op at divition"}, token_list_final}
  end
end


######################################### Tecera Entrega #####################################################
#add and substraction
  def pars_bin(token_list_final) do
    ## Hacemos lo mismo que la primera ,partimos la lista de tokens y nos quedamos con los que siguen
    #aqui checaremos si son multiplicacion o divicion
    # o checamos otras entregas
    #entonces dice vete a parse_term
    term= parse_term(token_list_final)

    {expression_node, rest} = term
    #Hacemos pattermacchin
    [next_Token | rest]= rest
     #to_list(enumerable)
     #Converts enumerable to a list.
    first= Tuple.to_list(next_Token)
    testing= List.last(first)

    case term do
      #En caso de error se lo mandamos
      {{:error, show_Message_Error}, token_list_final} ->
        {{:error, show_Message_Error}, token_list_final}
      _->
        case testing do
          [:add] -> #Tenemos el toquen de +?
            term_op= parse_expression(rest)

            case term_op do
              #En caso de error se lo mandamos
              {{:error, show_Message_Error}, token_list_final} ->
                {{:error, show_Message_Error}, token_list_final}
              _->
                #Mandamos el AST, si tenemos todo
                {node, token_list_final} = term_op
                {%AST{node_name: :binary, val: :add, lf_node: expression_node, rt_node: node}, token_list_final}
            end
          [:neg] -> #Tenemos el toquen de -?
            term_op= parse_expression(rest)

            case term_op do
              #En caso de error se lo mandamos
              {{:error, show_Message_Error}, token_list_final} ->
                {{:error, show_Message_Error}, token_list_final}
              _->
                #Mandamos el AST, si tenemos todo
                {node, token_list_final} = term_op
                {%AST{node_name: :binary, val: :neg, lf_node: expression_node, rt_node: node}, token_list_final}
            end
          _->
            term
        end
    end
  end
#mul nand divition
  def parse_term(token_list_final) do
    #Vete a parse_factor y checame si hay un primer operando u otra entrega
    factor= parse_factor(token_list_final)

    {expression_node, rest}= factor
    #Hacemos pattermaching
    [next_Token | _] = rest
     #to_list(enumerable)
     #Converts enumerable to a list.
    first= Tuple.to_list(next_Token)
    testing= List.last(first)

    case factor do
      #En caso de error se lo mandamos
      {{:error, show_Message_Error}, token_list_final} ->
        {{:error, show_Message_Error}, token_list_final}
      _ ->
        case testing do
          [:mul] -> #Tenemos el toquen de *?
            token_list_final= List.delete_at(rest, 0)
            term_op= parse_expression(token_list_final)

            case term_op do
              #En caso de error se lo mandamos
              {{:error, show_Message_Error}, token_list_final} ->
                {{:error, show_Message_Error}, token_list_final}
              _->
                #Mandamos el AST, si tenemos todo
                {node, token_list_final}= term_op
                {%AST{node_name: :binary, val: :mul, lf_node: expression_node, rt_node: node}, token_list_final}
            end
          [:div] -> #Tenemos el toquen de /?
            token_list_final= List.delete_at(rest, 0)
            term_op= parse_expression(token_list_final)
            case term_op do
              #En caso de error se lo mandamos
              {{:error, show_Message_Error}, token_list_final} ->
                {{:error, show_Message_Error}, token_list_final}
              _->
                {node, token_list_final}= term_op
                #Mandamos el AST, si tenemos todo
                {%AST{node_name: :binary, val: :div, lf_node: expression_node, rt_node: node}, token_list_final}
            end
            _->
              #Hacemos recursividad
              factor
        end
    end
  end


  def parse_factor(token_list_final) do
    next_Token = next(token_list_final)
    #to_list(enumerable)
    #Converts enumerable to a list.
    first = Tuple.to_list(hd(token_list_final))
    #Retornamos el ultimo elemento de la lista o nulo si la lista esta vacia
    testing = List.last(first)
    case {next_Token, testing} do
      #En caso de error se lo mandamos
      {{:error, show_Message_Error}, token_list_final} ->
        {{:error, show_Message_Error}, token_list_final}

      {:num, numero} -> #Si tenemos el valor,aqui creamos el nodo
        token_list_final = List.delete_at(token_list_final, 0)
        #El nodo tiene el nombre y el valor,aqui viene
        # token_list_finalel punto y coma y la llave
        {%AST{node_name: :constant, val: numero}, token_list_final}

      {:left_paren, []} ->
        token_list_final = List.delete_at(token_list_final, 0)
        expression= parse_expression(token_list_final)

        case expression do
          #En caso de error se lo mandamos
          {{:error, show_Message_Error}, token_list_final} ->
            {{:error, show_Message_Error}, token_list_final}

          {expression_node, token_list_final} ->
            [next_Token | rest]= token_list_final
            #to_list(enumerable)
             #Converts enumerable to a list.
             #aqui convertimos la tupla a lista
            first= Tuple.to_list(next_Token)
            #Regresamos el primer elemento
            testing= List.first(first)
            if testing== :right_paren do
              {expression_node, rest}
            else
              sec_expression= parse_expression(token_list_final)
              {node_expression, _} = expression
              {node, rest} = sec_expression
              [_ | no_OpenParentesis_list] = rest
              [%{node_expression | lf_node: node}, no_OpenParentesis_list]
            end
        end
      {:op, _} ->
        #Aqui le decimos ve a parse unary,porque para la segunda entrega debemos checar antes lo sig
        #  "-" ,   "!" ,   "!"
        parse_unary(token_list_final)
      _ ->
        line = line(token_list_final)
        {{:error, "I have found an error at #{line}: An integer val is expected"}, token_list_final}
    end
  end
############################################### Extras ###################################################
#Parse Expresion nos dira el valor del return
#De aqui nos vamos ir en cadena ,hasta llegar al valor,no es directo porque tenemos las
#tres entregas inplementadas ,por tanto seguira este algoritmo
  def parse_expression(token_list_final) do
    #Espera aqui y se va a parse_logicalAnd
    logical= parse_logicalAnd(token_list_final)
    case logical do
      #En caso de error se lo mandamos
      {{:error, show_Message_Error}, token_list_final}
      ->
        {{:error, show_Message_Error}, token_list_final}
      _->
            logical
        end
  end

  def parse_logicalAnd(token_list_final) do
    #Aqui hace una pausa y se va parse_equaxEx
    equality= parse_equaEx(token_list_final)

    case equality do
      #En caso de error se lo mandamos
      {{:error, show_Message_Error}, token_list_final}
      ->
        {{:error, show_Message_Error}, token_list_final}
      _->
            equality
        end
  end

  def parse_equaEx(token_list_final) do
    #Hace una pausa y se va parse_relatExp
    relational= parse_relatExp(token_list_final)
    case relational do
      #En caso de error se lo mandamos
      {{:error, show_Message_Error}, token_list_final}
      ->
        {{:error, show_Message_Error}, token_list_final}
      _->
            relational
        end
  end

  def  parse_relatExp(token_list_final) do
    #Le decimos vete a parse bin que es lo que se usa para la segunda entrega
    #Hacemos una pausa y vamos directamente a pars_bin
    binary= pars_bin(token_list_final)
    case binary do
      #En caso de error se lo mandamos
      {{:error, show_Message_Error}, token_list_final}
      ->
        {{:error, show_Message_Error}, token_list_final}
      _->
            binary
    end
  end
end
