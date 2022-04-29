module Batch

using ..Tools

using Serialization 

struct ModelGroupFileStructure

    names::Array{String}
    kfile_names::Array{String}
    local_root_path::String
    local_path::String
    remote_root_path::String 
    remote_path::String
    local_folders::Array{String}
    remote_folders::Array{String}

end


function define_model_group_file_structure(model_list, local_model_root_path, local_model_group_path, remote_model_root_path, remote_model_group_path)

    num_models = length(model_list)

    model_names = Array{String}(undef, num_models)
    local_model_folders = Array{String}(undef, num_models)
    remote_model_folders = Array{String}(undef, num_models)
    kfile_names = Array{String}(undef, num_models)

    for i = 1:num_models

        model_names[i] = model_list[i]
        kfile_names[i] = model_list[i] * ".k"
        local_model_folders[i] = joinpath(local_model_group_path, model_names[i])
        remote_model_folders[i] = joinpath(remote_model_group_path, model_names[i])


    end

    model_group = ModelGroupFileStructure(model_names, kfile_names, local_model_root_path, local_model_group_path, remote_model_root_path, remote_model_group_path, local_model_folders, remote_model_folders)

    model_group_file_structure_path = joinpath(local_model_group_path, "model_group_file_structure")
    serialize(model_group_file_structure_path, model_group)

    return model_group

end

function create_local_model_group_directories(model_group)

    for i in eachindex(model_group.kfile_names)

        model_location = joinpath(model_group.local_path, model_group.names[i])
        run(`mkdir $model_location`)

    end

end

function generate_qsub_model_group_batch_file(qsub_batch_filename, local_model_group_path, qsub_filenames_with_remote_path, qsub_model_remote_paths)

    lines = Array{String}(undef, length(qsub_filenames_with_remote_path) * 2)

    for i in eachindex(qsub_filenames_with_remote_path)

        lines[2*i-1] = "cd " * qsub_model_remote_paths[i]
        lines[2*i] = "qsub " * qsub_filenames_with_remote_path[i] 

    end

    qsub_batch_filename_with_local_path = joinpath(local_model_group_path, qsub_batch_filename)
    Tools.write_file(qsub_batch_filename_with_local_path, lines)

end

function copy_model_group_remote_results_to_local(local_root_path, remote_root_path, model_list, output_file_list)

    for i in eachindex(model_list)

        Tools.copy_model_remote_results_to_local(local_root_path, remote_root_path, model_list[i], output_file_list)

    end

end



end #module