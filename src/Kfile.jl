
module Kfile

using Parsers


function get_node_geometry_from_lines(node_lines)

    num_nodes = length(node_lines)

    node_geometry = Array{Float64}(undef, (num_nodes, 3))

    for i = 1:num_nodes

        opts = Parsers.Options(delim=' ', ignorerepeated=true, wh1=0x00)
        io = []
        io = IOBuffer(lstrip(node_lines[i][9:end]))
        node_geometry[i,1] = Parsers.parse(Float64, io, opts)
        node_geometry[i,2]= Parsers.parse(Float64, io, opts)
        node_geometry[i,3] = Parsers.parse(Float64, io, opts)

    end

    return node_geometry
    
end


end #module
