
using LSDYNA
using CrossSection


cross_section = [[0.0, 0.0], [1.0, 1.0], [2.0, 0.0]]

z = 0.0:1.0:36.0

t = 0.100

extrude_cross_section_with_solid_elements(cross_section, z, t)

function extrude_cross_section_with_solid_elements(cross_section, z, t)

    num_solid_element_layers = 2
    num_cross_sections = length(z)
    num_cross_section_nodes_layer = size(cross_section, 1)
    num_nodes_cross_section = (num_solid_element_layers + 1) * num_cross_section_nodes_layer

    # cross_section = [centerline_coords[1] centerline_coords[2]]
    
#     unit_node_normals = CrossSection.Tools.calculate_cross_section_unit_node_normals(cross_section)
# #Get centerline coords
#     centerline = CrossSection.Tools.get_coords_along_node_normals(cross_section, unit_node_normals, t/2)
    
    
    unit_node_normals = CrossSection.Tools.calculate_cross_section_unit_node_normals(cross_section)

    Δ = t/2
    # xcoords = cross_section[:,1]
    # ycoords = cross_section[:, 2]
    top_coords = CrossSection.Tools.get_coords_along_node_normals(cross_section, unit_node_normals, Δ)

    Δ = -t/2
    # xcoords = cross_section[:,1]
    # ycoords = cross_section[:, 2]
    bottom_coords = CrossSection.Tools.get_coords_along_node_normals(cross_section, unit_node_normals, Δ)

    # using Plots
    # plot(top_coords[1], top_coords[2], markershape = :o, legend=false)
    # plot!(centerline_coords[:, 1], centerline_coords[:, 2], markershape = :o)
    # plot!(bottom_coords[1], bottom_coords[2], markershape = :o)
    # # ylims!(-10.0, 10.0)

    X = [top_coords[i][1] for i in eachindex(cross_section)]
    Y = [top_coords[i][2] for i in eachindex(cross_section)]

    cross_section_nodes = [X Y]


    X = [cross_section[i][1] for i in eachindex(cross_section)]
    Y = [cross_section[i][2] for i in eachindex(cross_section)]

    cross_section_nodes = [cross_section_nodes; [X Y] ]

    X = [bottom_coords[i][1] for i in eachindex(cross_section)]
    Y = [bottom_coords[i][2] for i in eachindex(cross_section)]
    cross_section_nodes = [cross_section_nodes; [X Y] ]
     
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