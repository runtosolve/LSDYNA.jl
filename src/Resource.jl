
module Resource


function find_target_line_in_output_file(target_string, lines)

    for i in eachindex(lines)

        index=findfirst(target_string,lines[i])

        if isnothing(index)==false
            target_line = i
            return target_line
        end

    end

end

function read_output_file(filename)

    #Open the template LS-DYNA .k file.
    file = open(filename,"r")

    #Read all the lines in the template LS-DYNA .k file.
    lines = readlines(file)

    #Close the template file.
    close(file)

    return lines

end

end #module