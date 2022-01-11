module ASCII


###### created for binary files converted to ascii 
struct NodalForceGroupOutput

    nd::Array{Int64}
    xforce::Array{Float64}
    yforce::Array{Float64}
    zforce::Array{Float64}
    energy::Array{Float64}
    setid::Array{Int64}

end

function get_nodal_force_group_ouput_at_timestep(num_nodes, line_segment)

    nd = Array{Int64}(undef, num_nodes)
    xforce = Array{Float64}(undef, num_nodes)
    yforce = Array{Float64}(undef, num_nodes)
    zforce = Array{Float64}(undef, num_nodes)
    energy = Array{Float64}(undef, num_nodes)
    setid = Array{Int64}(undef, num_nodes)

    for i = 1:num_nodes

            nd[i] = parse(Float64, line_segment[i][5:12])
            xforce[i] = parse(Float64, line_segment[i][24:34])   
            yforce[i] = parse(Float64, line_segment[i][47:57])   
            zforce[i] = parse(Float64, line_segment[i][69:79])   
            energy[i] = parse(Float64, line_segment[i][92:103])   
            setid[i] = parse(Float64, line_segment[i][113:120])   

    end

    nodal_output = NodalForceGroupOutput(nd, xforce, yforce, zforce, energy, setid)

    return nodal_output

end

function get_nodal_force_group_output_all_timesteps(lines, num_nodes)

    target_string = " n o d a l   f o r c e   g r o u p    o u t p u t   t="

    step_index = find_output_file_step_indices(lines, target_string)

    nodal_force_output = Array{NodalForceGroupOutput}(undef, length(step_index))

    for i in eachindex(step_index)

            start_index = step_index[i] + 8
            end_index = start_index + num_nodes - 1
            line_segment = lines[start_index:end_index]

            nodal_force_output[i] = get_nodal_force_group_ouput_at_timestep(num_nodes, line_segment)

    end

    return nodal_force_output

end

end