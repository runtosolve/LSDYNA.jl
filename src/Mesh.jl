
module Mesh

using ..Tools


function mesh_STEP_file_with_shells(step_filename, kfile_filename, cfile_filename, cfile_path, mesh_size, prepost_version)

    list = Vector{String}(undef, 16)

    list[1] = "stepreadconfig MM 1 1 "
    list[2] = "open step " * '"' * step_filename * '"'
    list[3] = "ac"

    list[4] = "genselect target occobject"
    list[5] = "occfilter clear"
    list[6] = "occfilter add Face"

    
    list[7] = "genselect whole"
    list[8] = "occmesh mesh 0, 1 0 1 " * string(mesh_size) * " 0 0"
    list[9] = "occmesh accept 1 0.0001 0 1"
    list[10] = "genselect clear"
    list[11] = "save keywordabsolute 0"
    list[12] = "save keywordbylongfmt 0"
    list[13] = "save keywordbyi10fmt 0"
    list[14] = "save outversion 9"
    list[15] = "save keyword " * '"' * kfile_filename * '"'
    list[16] = "exit"

    Tools.write_file(cfile_filename, list)

    run(Cmd(`LS-$prepost_version c=$cfile_filename`, dir=cfile_path))

end

end #module 