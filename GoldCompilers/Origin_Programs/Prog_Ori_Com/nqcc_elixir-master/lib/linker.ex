defmodule Linker do
  #funcion generate_binary,recibe el codigo esamblador y la ruta donde quiero que se guarde.
  def generate_binary(assembler, assembly_path) do
    assembly_file_name = Path.basename(assembly_path)
    binary_file_name = Path.basename(assembly_path, ".s")
    output_dir_name = Path.dirname(assembly_path)
    assembly_path = output_dir_name <> "/" <> assembly_file_name

    File.write!(assembly_path, assembler)
    #Llamo al gcc cómo etapa final y le digo que nombre va a tener el ejecutable
    System.cmd("gcc", [assembly_file_name, "-o#{binary_file_name}"], cd: output_dir_name)
    #Una vez hecho guardamelo en la ruta especificada.
    File.rm!(assembly_path)
  end
end
