module Binary


function get_output(lines, target_string, num_points, skip_beginning_lines)

    start_line = LSDYNA.find_target_line_in_output_file(target_string, lines)

    data = lines[(start_line + skip_beginning_lines + 1):(start_line + skip_beginning_lines + num_points)]

    x = [parse(Float64, data[i][5:20]) for i=1:num_points]
    y = [parse(Float64, data[i][24:40]) for i=1:num_points]

    return x, y
end


function find_output_file_step_indices(lines, target_string)

    step_index = []

    for i in eachindex(lines)

            target_line = findfirst(target_string, lines[i])

            if isnothing(target_line)==false
                    push!(step_index, i)
            end

    end

    return step_index

end

end #module

