
#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

defmodule FOXY do
  def main(args) do
    # Our compiler options
    case args do
      ############################################ HELP #################################################
      ["-h"] ->
        IO.puts("\n**************************************************************************************\n")
        IO.puts("You can use the following shortcuts:                                                 *\n
        -t [filename.c]  It shows  us the token list.                                *
        -a [filename.c]  It shows  us the AST.                                       *
        -s [filename.c]  It shows  us the assembly.                                  *
        -c [filename.c]  It compile program.                                         *")
        IO.puts("\n**************************************************************************************\n")

      ############################################ TOKEN ################################################
      ["-t", path] ->
            IO.puts("\n The token list is : \n")
            #Aqui se ira al LEX y se va la funcion lexs y esta dice:
            #If we find something strange, we will notify you that you found
            IO.inspect(LEX.lexs(File.read!(path)))
      ############################################ AST ###################################################
      ["-a", path] ->
        IO.puts("\n The AST is:\n")
        #Aqui se ira al LEX y se va la funcion lexs y esta dice:
        #If we find something strange, we will notify you that you found
        toks = LEX.lexs(File.read!(path))
        #Nos vamos a PAR y esta se va a la funcion pars_prog y esta revisa a los tokens
        ast = PAR.pars_prog(toks)
        IO.inspect(ast)

      ############################################ ASSEMBLY ##############################################
      ["-s", path] ->
        IO.puts("The assembly code is:\n")
        #Aqui se ira al LEX y se va la funcion lexs y esta dice:
        #If we find something strange, we will notify you that you found
        toks = LEX.lexs(File.read!(path))
        #Nos vamos a PAR y esta se va a la funcion pars_prog y esta revisa a los tokens
        ast = PAR.pars_prog(toks)
        assemCod = CODEGENERATOR.gnt_Code(ast)
        IO.puts(assemCod)

      ############################################ COMPILE ##############################################
      ["-c", path] ->
        IO.puts("\n************************************************************************************\n")
        IO.puts("\nThe compiling the file is : \n "<>"\n"<>path)
        IO.puts("\n************************************************************************************\n")
        #Aqui se ira al LEX y se va la funcion lexs y esta dice:
        #If we find something strange, we will notify you that you found
        toks = LEX.lexs(File.read!(path))
        #Nos vamos a PAR y esta se va a la funcion pars_prog y esta revisa a los tokens
        ast = PAR.pars_prog(toks)
        assemCod = CODEGENERATOR.gnt_Code(ast)
        LINK.genBin(assemCod, path)

      _ ->

        IO.puts("**************************************************************************************")
        IO.puts("You can use the following shortcuts:                                                 *\n
        -t [filename.c]  It shows  us the token list.                                *
        -a [filename.c]  It shows  us the AST.                                       *
        -s [filename.c]  It shows  us the assembly.                                  *
        -c [filename.c]  It compile program.                                         *")
        IO.puts("**************************************************************************************")
    end
  end
end
