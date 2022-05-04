using LSDYNA


nodes = [0.0 0.0;
         1.0 2.0;
         3.0 4.3;
         7.5 3.6]


kfile_name = "extrusion_test.k"
kfile_path = "/Users/crismoen/.julia/dev/LSDYNA/test/extrusion"

cfile_name = "extrusion_test.cfile"
cfile_path = "/Users/crismoen/.julia/dev/LSDYNA/test/extrusion"

extrusion_length = 200.35
num_length_segments = 13

prepost_version = "PrePost-4.8"

Mesh.extrude_cross_section_with_shells(nodes, kfile_name, kfile_path, cfile_name, cfile_path, extrusion_length, num_length_segments, prepost_version)