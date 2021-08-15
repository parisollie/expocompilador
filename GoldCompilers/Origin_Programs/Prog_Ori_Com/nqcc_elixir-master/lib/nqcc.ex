defmodule Nqcc do
  @moduledoc """
  Documentation for Nqcc.
  """
  @commands %{
    "help" => "Prints this help"
  }
  #args es la ruta del archivo.
  def main(args) do
    args
    |> parse_args
    |> process_args
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [help: :boolean])
  end

  defp process_args({[help: true], _, _}) do
    print_help_message()
  end

  defp process_args({_, [file_name], _}) do
    #Manda a llamar a la funcion compile
    compile_file(file_name)
  end

  defp compile_file(file_path) do
    IO.puts("Compiling file: " <> file_path)
    #Le cambio el .c al .s que es el esamblador.
    assembly_path = String.replace_trailing(file_path, ".c", ".s")
    #Leó el archivo punto c.
    File.read!(file_path)
    #Lo pasó por el modulo sanitize.
    |> Sanitizer.sanitize_source()
    |> IO.inspect(label: "\nSanitizer ouput")
    #La salida del sanatizer se la pasó al lexer ( es el escaner).
    #Toma toda la cadena ( no sabemos que puede ir ahi).
    #scan_words genera los toquens, hace lo posible para encontrar los toquens.
    |> Lexer.scan_words()
    |> IO.inspect(label: "\nLexer ouput")
    #La salida del lexer se la paso al escaner.
    #El parser recibe la lista de tokens.
    #Toma la lista de tokens y trata de construir el arbol ast.
    #el arbol de sintaxis abstracta.
    |> Parser.parse_program()
    |> IO.inspect(label: "\nParser ouput")
    #Una vez generado el arbol se para al generador de codigo.
    #Este va a devolver el codigo esamblador.
    |> CodeGenerator.generate_code() #back end.
    #Este se lo pasara al Linker.
    |> Linker.generate_binary(assembly_path)
    #Toma el codigo esamblador y se lo pasa al gcc, para que al final el gcc me genere mi ejecutable final.
  end

  defp print_help_message do
    IO.puts("\nnqcc --help file_name \n")

    IO.puts("\nThe compiler supports following options:\n")

    @commands
    |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
  end
end
