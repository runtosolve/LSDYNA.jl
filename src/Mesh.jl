
module Mesh

using ..Tools

using Printf, Formatting


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



function extrude_cross_section_with_shells(nodes, kfile_name, kfile_path, cfile_name, cfile_path, extrusion_length, num_length_segments, prepost_version)

    list = Vector{String}(undef, 0)

    for i in eachindex(nodes[1:end-1,1])
        fmt = "line param  0 {:.6f} {:.6f} 0 {:.6f} {:.6f}"
        push!(list, format(fmt, nodes[i,1], nodes[i,2], nodes[i+1,1],nodes[i+1,2]))
    end

    push!(list, "elgenerate shelltype 6")
    push!(list, "genselect target occobject")
    push!(list, "occfilter add Edge")
    push!(list, "genselect whole")
    
    fmt = "elgenerate shell curvedrag 1 1 {:s} {:s} 0 0 0 1 0 0 0"
    line = format(fmt, string(extrusion_length), string(num_length_segments))

    node_list = Vector{String}(undef, 0)
    for i in eachindex(nodes[1:end-1,1])
        node_list =[node_list; " $i"]
    end
    node_list = join(node_list)
    line = join([line; node_list])
    push!(list, line)

    push!(list, "elgenerate accept")
    push!(list, "genselect whole")
    push!(list, "dupnode merge 0.001000")

    line = "geomag del "
    node_list = Vector{String}(undef, 0)
    fmt = " {:s}e"
    for i in eachindex(nodes[1:end-1,1])
        node_line = format(fmt, string(i))
        node_list =[node_list; node_line]
    end
    node_list = join(node_list)
    line = join([line; node_list])
    push!(list, line)

    kfile_name_with_path = joinpath(kfile_path, kfile_name)
    push!(list, "save keyword " * '"' * kfile_name_with_path * '"')
    push!(list, "exit")

    cfile_name_with_path = joinpath(cfile_path, cfile_name)
    Tools.write_file(cfile_name_with_path, list)

    run(Cmd(`LS-$prepost_version c=$cfile_name`, dir=cfile_path))

end


end #module 

