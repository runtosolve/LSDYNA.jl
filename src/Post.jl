module Post

using ..Tools

function write_beam_element_history_file(dplot_path, cfile_filename, results_filename, beam_element, history_component, prepost_version)

    list = Vector{String}(undef, 8)

    list[1] = "open d3plot " * '"' * joinpath(dplot_path, "d3plot") * '"'
    list[2] = "genselect target element"
    list[3] = "genselect target beam"
    list[4] = "genselect beam add beam " * string(beam_element) * "/0"
    list[5] = "etype 1 ;etime " * string(history_component)
    list[6] = "xyplot 1 savefile curve_file " * '"' * results_filename * '"'
    list[7] = "xyplot 1 donemenu"
    list[8] = "exit"

    Tools.write_file(cfile_filename, list)

    run(Cmd(`LS-$prepost_version c=$cfile_filename`, dir=dplot_path))

end

function write_node_history_file(dplot_path, cfile_filename, results_filename, node_number, history_component, prepost_version)

    list = Vector{String}(undef, 7)

    list[1] = "open d3plot " * '"' * joinpath(dplot_path, "d3plot") * '"'
    list[2] = "genselect target node"
    list[3] = "genselect node add node " * string(node_number) * "/0"
    list[4] = "ntime " * string(history_component)
    list[5] = "xyplot 1 savefile curve_file " * '"' * results_filename * '"'
    list[6] = "xyplot 1 donemenu"
    list[7] = "exit"

    Tools.write_file(cfile_filename, list)

    run(Cmd(`LS-$prepost_version c=$cfile_filename`, dir=dplot_path))

end

# function write_node_history_file_from_binary(dplot_path, cfile_filename, results_filename, node_number, branch, history_component, prepost_version)

#     list = Vector{String}(undef, 9)

#     list[1] = "open d3plot " * '"' * dplot_path * "d3plot" * '"'
#     list[2] = "binaski init"
#     list[3] = "binaski load " * '"' * dplot_path * "binout0000" * '"'
#     list[4] = "binaski fileswitch " * '"' * dplot_path * "binout0000" * '"'
#     list[5] = "binaski loadblock /" * branch
#     list[6] = "binaski plot " * '"' * dplot_path * "binout0000" *  '"' * " " * branch * " 0 1 1 " * string(node_number) * " " * history_component  
#     list[7] = "xyplot 1 savefile curve_file " * '"' * results_filename * '"'
#     list[8] = "xyplot 1 donemenu"
#     list[9] = "exit"

#     Tools.write_file(cfile_filename, list)

#     run(Cmd(`LS-$prepost_version c=$cfile_filename`, dir=dplot_path))

# end


function write_node_history_file_from_binary(dplot_path, cfile_filename, results_filename, nodes, branch, history_component, prepost_version)

    num_nodes = length(nodes)

    if num_nodes > 1
        node_list = string.(nodes)
        node_list = join(node_list, " ")
    else #if just one node
        node_list = string.(nodes)
    end

    list = Vector{String}(undef, 9)

    list[1] = "open d3plot " * '"' * joinpath(dplot_path, "d3plot") * '"'
    list[2] = "binaski init"
    list[3] = "binaski load " * '"' * joinpath(dplot_path, "binout0000") * '"'
    list[4] = "binaski fileswitch " * '"' * joinpath(dplot_path, "binout0000") * '"'
    list[5] = "binaski loadblock /" * branch
    list[6] = "binaski plot " * '"' * joinpath(dplot_path, "binout0000") *  '"' * " " * branch * " $num_nodes 1 " * node_list * " " * history_component  
    list[7] = "xyplot 1 savefile curve_file " * '"' * results_filename * '"'
    list[8] = "xyplot 1 donemenu"
    list[9] = "exit"

    Tools.write_file(cfile_filename, list)

    run(Cmd(`LS-$prepost_version c=$cfile_filename`, dir=dplot_path))

end



function get_results_from_curveplot(results_nodes, filename, num_points)

    lines = Tools.read_text_file(filename)

    time_steps = Vector{Vector{Float64}}(undef, length(results_nodes))
    results = Vector{Vector{Float64}}(undef,  length(results_nodes))

    for i in eachindex(results_nodes)
        target_string = "T-" * string(results_nodes[i])
        line_index = Tools.find_target_line_in_text_file(target_string, lines)

        num_skip_lines = 2
        data = lines[line_index+ num_skip_lines + 1:line_index + num_skip_lines + num_points]

        time_steps[i] = [parse(Float64, data[i][5:20]) for i=1:num_points]
        results[i] = [parse(Float64, data[i][24:40]) for i=1:num_points]

    end


    return time_steps, results

end

function get_nodal_history_results_from_curveplot(results_nodes, filename, num_points)

    lines = Tools.read_text_file(filename)

    time_steps = Vector{Vector{Float64}}(undef, length(results_nodes))
    results = Vector{Vector{Float64}}(undef,  length(results_nodes))

    for i in eachindex(results_nodes)
        target_string = string(results_nodes[i])
        line_index = Tools.find_target_line_in_text_file(target_string, lines)

        num_skip_lines = 2
        data = lines[line_index+ num_skip_lines + 1:line_index + num_skip_lines + num_points]

        time_steps[i] = [parse(Float64, data[i][5:20]) for i=1:num_points]
        results[i] = [parse(Float64, data[i][24:40]) for i=1:num_points]

    end


    return time_steps, results

end




# function get_results_from_saved_curveplot(lines, target_string, num_points, skip_beginning_lines)

#     start_line = Tools.find_target_line_in_text_file(target_string, lines)

#     data = lines[(start_line + skip_beginning_lines + 1):(start_line + skip_beginning_lines + num_points)]

#     x = [parse(Float64, data[i][5:20]) for i=1:num_points]
#     y = [parse(Float64, data[i][24:40]) for i=1:num_points]

#     return x, y
# end

end  #module



# function cross_section_extruder(xcoords, ycoords, element_info, L, dL, path, scl_filename,lsdyna_filename)

#     cd(path)

#     io = open(scl_filename, "w")

#     println(io,"define:")
#     println(io,"void main(void)")
#     println(io,"{")

#     num_elem = size(element_info)[1]

#     for i=1:num_elem
#         @printf(io, "ExecuteCommand(\"line param  0 %f %f 0 %f %f\");\n", xcoords[i],ycoords[i],xcoords[i+1],ycoords[i+1])
#     end

#     println(io, "ExecuteCommand(\"elgenerate shelltype 6\");")
#     println(io, "ExecuteCommand(\"genselect target occobject\");")
#     println(io, "ExecuteCommand(\"occfilter add Edge\");")
#     println(io, "ExecuteCommand(\"genselect whole\");")

#     @printf(io, "ExecuteCommand(\"elgenerate shell curvedrag 1 1 %s %s 0 0 0 1 0 0 0",string(L), string(floor(L/dL)))

#     for i=1:num_elem
#         @printf(io," %s",string(i))
#     end

#     @printf(io, "\");\n")

#     println(io, "ExecuteCommand(\"elgenerate accept\");")

#     println(io, "ExecuteCommand(\"genselect whole\");")
#     println(io, "ExecuteCommand(\"dupnode merge 0.001000\");")

#     @printf(io, "ExecuteCommand(\"geomag del ")

#     for i=1:num_elem
#         @printf(io," %s",string(i, "e"))
#     end

#     @printf(io, "\");\n")

#     println(io, string("ExecuteCommand(\"save keyword \\","\"",path,"/",lsdyna_filename,"\\","\"\");"))

#     println(io,"}")
#     println(io,"main();")

#     close(io)

# end


# function cfile_cross_section_extruder(xcoords, ycoords, element_info, L, dL, cfile_filename,lsdyna_filename)

#     # cd(path)

#     io = open(cfile_filename, "w")

#     num_elem = size(element_info)[1]

#     for i=1:num_elem
#         @printf(io, "line param  0 %f %f 0 %f %f\n", xcoords[i],ycoords[i],xcoords[i+1],ycoords[i+1])
#     end

#     println(io, "elgenerate shelltype 6")
#     println(io, "genselect target occobject")
#     println(io, "occfilter add Edge")
#     println(io, "genselect whole")

#     @printf(io, "elgenerate shell curvedrag 1 1 %s %s 0 0 0 1 0 0 0",string(L), string(floor(L/dL)))

#     for i=1:num_elem
#         @printf(io," %s",string(i))

#         if i==num_elem
#             @printf(io," %s\n",string(i))
#         end
#     end

#     println(io, "elgenerate accept")

#     # println(io, "genselect whole")
#     # println(io, "dupnode merge 0.4000")

#     @printf(io, "geomag del ")

#     for i=1:num_elem
#         @printf(io," %s",string(i, "e"))
        
#         if i==num_elem
#             @printf(io," %s\n",string(i, "e"))
#         end
#     end

  
#     println(io, "dupnode open 1")
#     @printf(io, "dupnode showdup %f\n", dL/100)
#     println(io, "dupnode select 1")
#     println(io, "genselect target node")
#     println(io, "genselect node add part 1/0")
#     @printf(io, "dupnode merge %f\n", dL/100)  #this dL/100 is a little tricky, might merge nodes not intended to be merged for a very fine mesh
#     println(io, "genselect clear")
#     println(io, "dupnode accept")

#     # kfile_path="/Volumes/GoogleDrive/Shared drives/RunToSolve/Projects/Geometrica/cladding_study_2020/model_generation/all/"

#     # lsdyna_filename=kfile_path*"h_purlin_"*string(i)*"_"*string(i)*".k"

#     println(io, string("save keyword \"", lsdyna_filename, "\""))

#     close(io)

# end