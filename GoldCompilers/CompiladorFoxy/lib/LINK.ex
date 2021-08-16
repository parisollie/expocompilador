#Gold Compilers
#García Felipe Miguel (Project Manager)
#Felix Flores Paul Jaime ( Tester )
#SanJuan Aldape Diana Paola  (The System Integrator)

#############################################################################################################

# Diana


#Este es el ultimo paso de nuestro compilador,si ya llegamos aqui
#quiere decir que nuestro programa reconocio los tokens, checo que los tokens esten ordenados
#y que se haya creado el AST

#Linker: es un programa del sistema informático que toma uno o más archivos objeto generados por un
#compiler o un ensamblador y los combina en un solo archivo ejecutable

defmodule LINK do
  #Función genBin, recibe el código ensamblador y la ruta donde quiero que se guarde
  def genBin(assem, aseem_loc) do
    #Aqui armamos los paths ,le decimos al gcc que de donde tomara el arcvhivo,
    #tomara el codigo ensambaldor y vera hacia  donde lo manda y hara que genere el ejecutable
    aseem_loc = String.replace_trailing(aseem_loc, ".c", ".s")
    #Ponemos las extensiones
    # El nombre de nuestro ensamblador
    assem_name = Path.basename(aseem_loc)
    bin_name = Path.basename(aseem_loc, ".s")
    output_dir_name = Path.dirname(aseem_loc)

    aseem_loc = output_dir_name <> "/" <> assem_name
    #mandamos a escribir el codigo ensamblador,porque el GCC va a ir a leer el archivo donde
    #se encuentre el ensamblador
    File.write!(aseem_loc, assem)
    # Llamo a gcc como etapa final y le digo que obtendrá el ejecutable con cmd
     # El cmd también funciona para ubuntu

    #Mandamos a llamar el gcc ,el nombre del archivo se lo pasaremos con (-o) el nombre del binario
    #y le decimos el directorio donde no los va a colocar.

    System.cmd("gcc", [bin_name <> ".c", "-o#{bin_name}"], cd: output_dir_name)
    # Una vez hecho, guárdelo en la ruta especificada


    #Finalmente mostramos el nombre de nuestro compilador en pantalla

    IO.puts("\nThe program has worked correctly :D, your executables have been generated: \n")

    IO.puts("....................................................................................\n")

    IO.puts("The asambler it's located in the following route: #{aseem_loc}         ")

    IO.puts("....................................................................................\n")

    IO.puts("The executable it's located in the following route: #{output_dir_name}"<>"/." <> "/" <> "#{bin_name} ")
    IO.puts("....................................................................................\n")
  end
end
