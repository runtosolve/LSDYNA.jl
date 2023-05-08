
module Kfile


function get_node_geometry_from_lines(node_lines)

    num_nodes = length(node_lines)

    node_geometry = Array{Tuple{Int64, Float64, Float64, Float64}}(undef, num_nodes)

    for i = 1:num_nodes
            
        if node_lines[i][24] == ' '
            node_lines[i] =  node_lines[i][1:22] * "0.0" * node_lines[i][25:end]
        end

        if node_lines[i][40] == ' '
            node_lines[i] =  node_lines[i][1:38] * "0.0" * node_lines[i][41:end]
        end

        if node_lines[i][56] == ' '
            node_lines[i] =  node_lines[i][1:54] * "0.0" * node_lines[i][57:end]
        end

        io = split(node_lines[i][1:end], " ")
        io = filter(x->x != "", io)

        node_number = parse(Int, io[1])
        x = parse(Float64, io[2])
        y = parse(Float64, io[3])
        z = parse(Float64, io[4])

        node_geometry[i] = (node_number, x, y, z)

    end

    return node_geometry
    
end

function get_element_connectivity_from_lines(element_lines)

    num_elements = length(element_lines)

    element_connectivity = Array{Int64}(undef, (num_elements, 10))

    for i = 1:num_elements

        io = split(element_lines[i], " ")
        io = filter(x->x != "", io)

        for j in eachindex(io)
            element_connectivity[i,j] = parse(Float64, io[j])
        end
        # element_connectivity[i,2]= parse(Float64, io[2])
        # element_connectivity[i,3] = parse(Float64, io[3])
        # element_connectivity[i,4] = parse(Float64, io[4])
        # element_connectivity[i,5] = parse(Float64, io[5])
        # element_connectivity[i,6] = parse(Float64, io[6])
        # element_connectivity[i,7] = parse(Float64, io[7])
        # element_connectivity[i,8] = parse(Float64, io[8])
        # element_connectivity[i,9] = parse(Float64, io[9])
        # element_connectivity[i,10] = parse(Float64, io[10])

    end

    return element_connectivity

end

end #module
