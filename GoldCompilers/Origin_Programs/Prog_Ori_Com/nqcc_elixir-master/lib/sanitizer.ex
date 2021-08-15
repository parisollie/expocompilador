defmodule Sanitizer do
  #En elixir es lo mismo usar do a la llave que cierra.
  #Se define la funcion llamada sanitizer y le mandamos el archivo.
  def sanitize_source(file_content) do
    #Nos imprime los que esta recibiendo.
      IO.puts("Compiling source: " <> file_content)#Norberto
      #Esta eliminando los espacios con trim.
    trimmed_content = String.trim(file_content)
    #Expresion regular del split
    #\s ,es para representar cualquier caracter.
    #+ ,es uno o mas espacios.
    # / / ,esos son los delimitadores para ver donde acaba la exprecion regular.
    Regex.split(~r/\s+/, trimmed_content)
  end
end
