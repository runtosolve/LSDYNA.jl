
module Kfile


function get_node_geometry_from_lines(node_lines)

    num_nodes = length(node_lines)

    node_geometry = Array{Tuple{Int64, Float64, Float64, Float64}}(undef, num_nodes)

    for i = 1:num_nodes

        io = split(node_lines[i][1:end], " ")
        io = filter(x->x != "", io)
        node_number = parse(Int, io[1])
        x = parse(Float64, io[2])
        y = parse(Float64, io[3])
        z = parse(Float64, io[4])


        # opts = Parsers.Options(delim=' ', ignorerepeated=true, wh1=0x00)
        # io = IOBuffer(lstrip(node_lines[i][1:end]))
        # node_number = Int(Parsers.parse(Float64, io, opts))
        # x = Parsers.parse(Float64, io, opts)
        # y = Parsers.parse(Float64, io, opts)
        # z = Parsers.parse(Float64, io, opts)

        node_geometry[i] = (node_number, x, y, z)

    end

    return node_geometry
    
end

function get_solid_element_connectivity_from_lines(element_lines)

    num_elements = length(element_lines)

    element_connectivity = Array{Int64}(undef, (num_elements, 10))

    for i = 1:num_elements

        io = split(element_lines[i], " ")
        io = filter(x->x != "", io)

        # opts = Parsers.Options(delim=' ', ignorerepeated=true, wh1=0x00)
        # io = IOBuffer(lstrip(element_lines[i]))

        element_connectivity[i,1] = parse(Float64, io[1])
        element_connectivity[i,2]= parse(Float64, io[2])
        element_connectivity[i,3] = parse(Float64, io[3])
        element_connectivity[i,4] = parse(Float64, io[4])
        element_connectivity[i,5] = parse(Float64, io[5])
        element_connectivity[i,6] = parse(Float64, io[6])
        element_connectivity[i,7] = parse(Float64, io[7])
        element_connectivity[i,8] = parse(Float64, io[8])
        element_connectivity[i,9] = parse(Float64, io[9])
        element_connectivity[i,10] = parse(Float64, io[10])

    end

    return element_connectivity

end

end #module
