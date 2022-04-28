
module Kfile

using Parsers


function get_node_geometry_from_lines(node_lines)

    num_nodes = length(node_lines)

    node_geometry = Array{Tuple{Int64, Float64, Float64, Float64}}(undef, num_nodes)

    for i = 1:num_nodes

        opts = Parsers.Options(delim=' ', ignorerepeated=true, wh1=0x00)
        io = IOBuffer(lstrip(node_lines[i][1:end]))
        node_number = Int(Parsers.parse(Float64, io, opts))
        x = Parsers.parse(Float64, io, opts)
        y = Parsers.parse(Float64, io, opts)
        z = Parsers.parse(Float64, io, opts)

        node_geometry[i] = (node_number, x, y, z)

    end

    return node_geometry
    
end

function get_solid_element_connectivity_from_lines(element_lines)

    num_elements = length(element_lines)

    element_connectivity = Array{Int64}(undef, (num_elements, 10))

    for i = 1:num_elements
        opts = Parsers.Options(delim=' ', ignorerepeated=true, wh1=0x00)
        io = IOBuffer(lstrip(element_lines[i]))
        element_connectivity[i,1] = Parsers.parse(Float64, io, opts)
        element_connectivity[i,2]= Parsers.parse(Float64, io, opts)
        element_connectivity[i,3] = Parsers.parse(Float64, io, opts)
        element_connectivity[i,4] = Parsers.parse(Float64, io, opts)
        element_connectivity[i,5] = Parsers.parse(Float64, io, opts)
        element_connectivity[i,6] = Parsers.parse(Float64, io, opts)
        element_connectivity[i,7] = Parsers.parse(Float64, io, opts)
        element_connectivity[i,8] = Parsers.parse(Float64, io, opts)
        element_connectivity[i,9] = Parsers.parse(Float64, io, opts)
        element_connectivity[i,10] = Parsers.parse(Float64, io, opts)

    end

    return element_connectivity

end

end #module
