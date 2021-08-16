#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

# Miguel


#Este es el ultimo paso de nuestro compilador,si ya llegamos aqui
#quiere decir que nuestro programa reconocio los tokens, checo que los tokens esten ordenados
#y que se haya creado el AST

#Linker: es un programa del sistema informático que toma uno o más archivos objeto generados por un
#compiler o un ensamblador y los combina en un solo archivo ejecutable

defmodule LINK do
  #genBin function, receives the assembly code and the path where I want it to be saved
  def genBin(assem, aseem_loc) do
    #Aqui armamos los paths ,le decimos al gcc que de donde tomara el arcvhivo,
    #tomara el codigo ensambaldor y vera hacia  donde lo manda y hara que genere el ejecutable
    aseem_loc = String.replace_trailing(aseem_loc, ".c", ".s")
    #We put the extensions
    #The name of our assembler
    assem_name = Path.basename(aseem_loc)
    bin_name = Path.basename(aseem_loc, ".s")
    output_dir_name = Path.dirname(aseem_loc)

    aseem_loc = output_dir_name <> "/" <> assem_name
    #mandamos a escribir el codigo ensamblador,porque el GCC va a ir a leer el archivo donde
    #se encuentre el ensamblador
    File.write!(aseem_loc, assem)
    #I call gcc as the final stage and tell it that it will have the executable con cmd
    #The cmd also works for ubuntu

    #Mandamos a llamar el gcc el nombre del archivo que le pasamos con -o el nombre del binario
    #y le decimos el directorio donde no los va a colocar.

    System.cmd("gcc", [bin_name <> ".c", "-o#{bin_name}"], cd: output_dir_name)
    #Once done save it to the specified path

    #######Al final removemos el codigo ensambalador para que no haya basura
    #File.rm!(assem_loc)

    #Finalmente mostramos el nombre de nuestro compilador en pantalla

    IO.puts("\nThe program has worked correctly :D, your executables have been generated: \n")

    IO.puts("....................................................................................\n")

    IO.puts("The asambler it's located in the following route: #{aseem_loc}         ")

    IO.puts("....................................................................................\n")

    IO.puts("The executable it's located in the following route: #{output_dir_name}"<>"/." <> "/" <> "#{bin_name} ")
    IO.puts("....................................................................................\n")
  end
end
