
using LSDYNA

cross_section = [[0.0, 0.0], [1.0, 1.0], [2.0, 0.0]]

z = 0.0:1.0:36.0

t = 0.100

part_number = 1

nodes, elements = LSDYNA.Mesh.extrude_cross_section_with_solid_elements(cross_section, z, t, part_number)
