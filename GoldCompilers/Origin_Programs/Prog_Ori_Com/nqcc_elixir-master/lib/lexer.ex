defmodule Lexer do
  def scan_words(words) do
    Enum.flat_map(words, &lex_raw_tokens/1)
  end

  def get_constant(program) do
    #Hago una expresion regular para devolver el numero.
    case Regex.run(~r/^\d+/, program) do
      [value] ->
        {{:constant, String.to_integer(value)}, String.trim_leading(program, value)}

      program ->
        #Si no es valido devuelvo el error.
        {:error, "Token not valid: #{program}"}
    end
  end
 #El lexer recibe el programa y nos da la lista de tokens.

  def lex_raw_tokens(program) when program != "" do
    {token, rest} =
    #Catalogo de los tokens.
      case program do
        "{" <> rest ->
          {:open_brace, rest}

        "}" <> rest ->
          {:close_brace, rest}

        "(" <> rest ->
          {:open_paren, rest}

        ")" <> rest ->
          {:close_paren, rest}

        ";" <> rest ->
          {:semicolon, rest}

        "return" <> rest ->
          {:return_keyword, rest}

        "int" <> rest ->
          {:int_keyword, rest}

        "main" <> rest ->
          {:main_keyword, rest}

        rest ->
          get_constant(rest)
      end

    if token != :error do
      remaining_tokens = lex_raw_tokens(rest)
      [token | remaining_tokens]
    else
      #Este lexer no reporta correctamente.
      #Se debe poner este toke que me diste no existe ,error en la linea dos
      [:error]
    end
  end

  def lex_raw_tokens(_program) do
    []
  end
end
