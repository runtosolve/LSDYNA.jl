
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


function extrude_cross_section_with_solid_elements(centerline_coords, z, t)

    num_solid_element_layers = 2
    num_cross_sections = length(z)
    num_cross_section_nodes_layer = size(centerline_coords[1])[1]
    num_nodes_cross_section = (num_solid_element_layers + 1) * num_nodes_centerline

    cross_section = [centerline_coords[1] centerline_coords[2]]
    unit_node_normals = CrossSection.Tools.calculate_cross_section_unit_node_normals(cross_section)

    Δ = t/2
    xcoords = cross_section[:,1]
    ycoords = cross_section[:, 2]
    top_coords = CrossSection.Tools.get_coords_along_node_normals(xcoords, ycoords, unit_node_normals, Δ)

    Δ = -t/2
    xcoords = cross_section[:,1]
    ycoords = cross_section[:, 2]
    bottom_coords = CrossSection.Tools.get_coords_along_node_normals(xcoords, ycoords, unit_node_normals, Δ)

    # using Plots
    # plot(top_coords[1], top_coords[2], markershape = :o, legend=false)
    # plot!(centerline_coords[:, 1], centerline_coords[:, 2], markershape = :o)
    # plot!(bottom_coords[1], bottom_coords[2], markershape = :o)
    # # ylims!(-10.0, 10.0)

    cross_section_nodes = [top_coords[1] top_coords[2]]
    cross_section_nodes = [cross_section_nodes; [centerline_coords[1] centerline_coords[2]] ]
    cross_section_nodes = [cross_section_nodes; [bottom_coords[1] bottom_coords[2]] ]
     
    #Generate the nodal coordinate array for the whole model.

    nodes = Array{Float64}(undef, 0, 3)
    for i = 1:num_cross_sections

        cross_section_nodes_xyz = [cross_section_nodes ones(Float64, num_nodes_cross_section) * z[i]]
        nodes = vcat(nodes, cross_section_nodes_xyz)

    end

    #Calculate the number of solid elements in one layer of the cross-section.
    num_solid_elements_cross_section_layer = num_cross_section_nodes_layer - 1

    #Calculate the number of solid elements in the cross-section.
    num_solid_elements_cross_section = num_solid_elements_cross_section_layer * num_solid_element_layers

    #Define the number of model segments along the length.
    num_model_segments = num_cross_sections - 1

    #Calculate total number of solid elements in the model.
    num_solid_elements = num_solid_elements_cross_section * num_model_segments

    #Initialize the solid element definition array.

    solid_elements = zeros(Int64, (num_solid_elements, 9))

    element_number = 0

    for k = 1:num_model_segments

        for j = 1:num_solid_element_layers

            for i=1:num_solid_elements_cross_section_layer

                    n_1 = i + (j - 1) * num_cross_section_nodes_layer + (k - 1) * num_nodes_cross_section
                    n_2 = i + j * num_cross_section_nodes_layer + (k - 1) * num_nodes_cross_section
                    n_3 = n_2 + 1
                    n_4 = n_1 + 1
                    n_5 = n_1 + num_nodes_cross_section
                    n_6 = n_2 + num_nodes_cross_section
                    n_7 = n_3 + num_nodes_cross_section
                    n_8 = n_4 + num_nodes_cross_section

                element_number = element_number + 1

                solid_element_cell = [element_number n_1 n_2 n_3 n_4 n_5 n_6 n_7 n_8]

                solid_elements[element_number, :] = solid_element_cell

            end

        end

    end

    return nodes, solid_elements

end


end #module 

