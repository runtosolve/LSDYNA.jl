
module Tools


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

    file = open(filename,"r")

    #Read all the lines.
    lines = readlines(file)
    
    close(file)

    return lines

end

function write_file(save_filename, lines)

    file = open(save_filename,"w")

    for i in eachindex(lines)
        write(file,"\n",lines[i])
    end

    close(file)

end


function create_model_run_directories(model_paths)

    for i in eachindex(model_paths)

        mkpath(model_paths[i])
        # mkpath(model_results_paths[i])

    end

end

function generate_qsub_sh_file(qsub_filename_with_local_path, model_name, filename, walltime)

    lines = Array{String}(undef, 14)

    lines[1] = "#PBS -S /bin/bash"
    lines[2] = "#PBS -q B30"
    lines[3] = "#PBS -l nodes=1:ppn=1"
    lines[4] = "#PBS -j oe"
    lines[5] = "#PBS -N " * model_name * ".sh" 
    lines[6] = "#PBS -r n"
    lines[7] = "#PBS -l walltime=" * walltime
    lines[8] = "#PBS -l qos=serial"
    lines[9] = "LSDYNA_INPUT=" * filename
    lines[10] = "cd \$PBS_O_WORKDIR"
    lines[11] = "module load lsdyna/12.0.0"
    lines[12] = "export LSTC_LICENSE_SERVER=64.227.2.64"
    lines[13] = "time mpirun -np 1 mpp971-d I=\$LSDYNA_INPUT"
    lines[14] = "exit \$?"

    write_file(qsub_filename_with_local_path, lines)

end



end #module