module Keyword

using Printf, Formatting

function BOUNDARY_SPC_SET_ID(id, title, nsid, cid, dofx, dofy, dofz, dofrx, dofry, dofrz)

    list = Matrix{String}(undef, 5, 1)

    list[1] = "*BOUNDARY_SPC_SET_ID"

    list[2] = "\$#      id                                                               heading"

    fmt = " {:9d}{:s}"
    list[3] = format(fmt, id, title)

    list[4] = "\$#    nsid       cid      dofx      dofy      dofz     dofrx     dofry     dofrz"

    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"

    list[5] = format(fmt, nsid, cid, dofx, dofy, dofz, dofrx, dofry, dofrz)

    return list

end


function CONTACT_AUTOMATIC_SINGLE_SURFACE(ssid, msid, sstyp, mstyp, sboxid, mboxid, spr, mpr, fs, fd, dc, vc, vdc, penchk, bt, dt, sfs, sfm, sst, mst, sfst, sfmt, fsf, vsf)

    list = Matrix{String}(undef, 7, 1)

    list[1] = "*CONTACT_AUTOMATIC_SINGLE_SURFACE"
    
    list[2] = "\$#    ssid      msid     sstyp     mstyp    sboxid    mboxid       spr       mpr  "
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"
    list[3]  = format(fmt, ssid, msid, sstyp, mstyp, sboxid, mboxid, spr, mpr)

    list[4] = "\$#      fs        fd        dc        vc       vdc    penchk        bt        dt"
    fmt = "{:10.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9d} {:9.1f}{:9.4e}"
    list[5] = format(fmt, fs, fd, dc, vc, vdc, penchk, bt, dt)

    list[6] = "\$#     sfs       sfm       sst       mst      sfst      sfmt       fsf       vsf"
    fmt = "{:10.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f}"
    list[7] = format(fmt, sfs, sfm, sst, mst, sfst, sfmt, fsf, vsf)

    return list

end


function CONTROL_ENERGY(hgen, rwen, slnten, rylen, irgen)

    list = Matrix{String}(undef, 3, 1)

    #Define formatting.
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d}"

    list[1] = "*CONTROL_ENERGY"
    list[2] = "\$#    hgen      rwen    slnten     rylen     irgen"
    list[3]  = format(fmt, hgen, rwen, slnten, rylen, irgen) 
    
    return list

end


function CONTROL_HOURGLASS(ihq, qh)

    list = Matrix{String}(undef, 3, 1)

    #Define formatting.
    fmt = "{:10d} {:9.1f}"

    list[1] = "*CONTROL_HOURGLASS"
    list[2] = "\$#     ihq        qh"
    list[3]  = format(fmt, ihq, qh) 
    
    return list

end


function CONTROL_IMPLICIT_AUTO(iauto, iteopt, itewin, dtmin, dtmax, dtexp, kfail, kcycle)

    list = Matrix{String}(undef, 3, 1)

    #Define formatting.
    fmt = "{:10d} {:9d} {:9d} {:9.1f} {:9.1f} {:9.1f} {:9d} {:9d}"

    list[1] = "*CONTROL_IMPLICIT_AUTO"
    list[2] = "\$#   iauto    iteopt    itewin     dtmin     dtmax     dtexp     kfail    kcycle"
    list[3]  = format(fmt, iauto, iteopt, itewin, dtmin, dtmax, dtexp, kfail, kcycle)
    
    return list

end


function CONTROL_IMPLICIT_GENERAL(imflag, dt0, imform, nsbs, igs, cnstn, form, zero_v)

    list = Matrix{String}(undef, 3, 1)

    #Define formatting.
    fmt = "{:10d}{:6.4E} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"

    list[1] = "*CONTROL_IMPLICIT_GENERAL"
    list[2] = "\$#  imflag       dt0    imform      nsbs       igs     cnstn      form    zero_v"
    list[3]  = format(fmt, imflag, dt0, imform, nsbs, igs, cnstn, form, zero_v)

    return list

end


function CONTROL_IMPLICIT_SOLUTION(nsolvr, ilimit, maxref, dctol, ectol, rctol, lstol, abstol, dnorm, diverg, istif, nlprint, nlnorm, d3itctl, cpchk, arcctl, arcdir, arclen, arcmth, arcdmp, arcpsi, arcalf, arctim, lsmtd, lsdir, irad, srad, awgt, sred)

    list = Matrix{String}(undef, 9, 1)

    list[1] = "*CONTROL_IMPLICIT_SOLUTION"
    
    list[2] = "\$#  nsolvr    ilimit    maxref     dctol     ectol     rctol     lstol    abstol"
    fmt = "{:10d} {:9d} {:9d} {:9.3f} {:9.2f}{:9.4E} {:9.1f}{:9.4E}"
    list[3]  = format(fmt, nsolvr, ilimit, maxref, dctol, ectol, rctol, lstol, abstol)

    list[4] = "\$#   dnorm    diverg     istif   nlprint    nlnorm   d3itctl     cpchk"
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"
    list[5]  = format(fmt, dnorm, diverg, istif, nlprint, nlnorm, d3itctl, cpchk)

    list[6] = "\$#  arcctl    arcdir    arclen    arcmth    arcdmp    arcpsi    arcalf    arctim"
    fmt = "{:10d} {:9d} {:9.1f} {:9d} {:9d} {:9d} {:9d} {:9d}"
    list[7] = format(fmt, arcctl, arcdir, arclen, arcmth, arcdmp, arcpsi, arcalf, arctim)

    list[8] = "\$#   lsmtd     lsdir      irad      srad      awgt      sred"
    fmt = "{:10d} {:9d} {:9.1f} {:9.1f} {:9.1f} {:9.1f}"
    list[9] = format(fmt, lsmtd, lsdir, irad, srad, awgt, sred)

    return list

end


function CONTROL_IMPLICIT_SOLVER(lsolvr, lprint, negev, order, drcm, drcprm, autospc, autotol, lcpack, mtxdmp, iparm1, rparm1, rparm2, emxdmp, rdcmem)

    list = Matrix{String}(undef, 7, 1)

    list[1] = "*CONTROL_IMPLICIT_SOLVER"
    
    list[2] = "\$#  lsolvr    lprint     negev     order      drcm    drcprm   autospc   autotol"
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9.1f} {:9d} {:9.1f}"
    list[3]  = format(fmt, lsolvr, lprint, negev, order, drcm, drcprm, autospc, autotol)

    list[4] = "\$#  lcpack    mtxdmp    iparm1    rparm1    rparm2 "
    fmt = "{:10d} {:9d} {:9d}{:9.4E} {:9.3f}"
    list[5]  = format(fmt, lcpack, mtxdmp, iparm1, rparm1, rparm2)

    list[6] = "\$#  emxdmp    rdcmem "
    fmt = "{:10d} {:9.2f}"
    list[7] = format(fmt, emxdmp, rdcmem)

    return list

end


function CONTROL_SOLID(esort, fmatrix, niptets, swlocl, psfail, t10jtol, icohed, tet13k, pm1, pm2, pm3, pm4, pm5, pm6, pm7, pm8, pm9, pm10)

    list = Matrix{String}(undef, 5, 1)

    list[1] = "*CONTROL_SOLID"
    
    list[2] = "\$#   esort   fmatrix   niptets    swlocl    psfail   t10jtol    icohed    tet13k"
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9.1f} {:9d} {:9d}"
    list[3]  = format(fmt, esort, fmatrix, niptets, swlocl, psfail, t10jtol, icohed, tet13k)

    list[4] = "\$#   pm1     pm2     pm3     pm4     pm5     pm6     pm7     pm8     pm9    pm10"
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"
    list[5]  = format(fmt, pm1, pm2, pm3, pm4, pm5, pm6, pm7, pm8, pm9, pm10)

    return list

end


function CONTROL_SOLUTION(soln, nlq, isnan, lcint, lcacc, ncdcf, nocop)

    list = Matrix{String}(undef, 3, 1)

    list[1] = "*CONTROL_SOLUTION"
    
    list[2] = "\$#    soln       nlq     isnan     lcint     lcacc     ncdcf     nocop "
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"
    list[3]  = format(fmt, soln, nlq, isnan, lcint, lcacc, ncdcf, nocop)

    return list

end


function CONTROL_TERMINATION(endtim, endcyc, dtmin, endeng, endmas, nosol)

    list = Matrix{String}(undef, 3, 1)

    list[1] = "*CONTROL_TERMINATION"
    
    list[2] = "\$#  endtim    endcyc     dtmin    endeng    endmas     nosol "
    fmt = "{:10.5f} {:9d} {:9.1f} {:9.1f}{:9.4E} {:9d}"
    list[3]  = format(fmt, endtim, endcyc, dtmin, endeng, endmas, nosol)

    return list

end


function DATABASE_BINARY_D3PLOT(dt, lcdt, beam, npltc, psetid, ioopt, rate, cutoff, window, type, pset)

    list = Matrix{String}(undef, 5, 1)

    list[1] = "*DATABASE_BINARY_D3PLOT"
    
    list[2] = "\$#      dt      lcdt      beam     npltc    psetid   "
    fmt = "{:10.6f} {:9d} {:9d} {:9d} {:9d}"
    list[3]  = format(fmt, dt, lcdt, beam, npltc, psetid)

    list[4] = "\$#   ioopt      rate    cutoff    window      type      pset"
    fmt = "{:10d} {:9.1f} {:9.1f} {:9.1f} {:9d} {:9d}"
    list[5] = format(fmt, ioopt, rate, cutoff, window, type, pset)

    return list

end

function DATABASE_HISTORY_NODE_SET(id1, id2, id3, id4, id5, id6, id7, id8)

    list = Matrix{String}(undef, 3, 1)

    list[1] = "*DATABASE_HISTORY_NODE_SET"
    
    list[2] = "\$#     id1       id2       id3       id4       id5       id6       id7       id8 "
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"
    list[3]  = format(fmt, id1, id2, id3, id4, id5, id6, id7, id8)

    return list

end


function DATABASE_SPCFORC(dt, binary, lcur, ioopt)

    list = Matrix{String}(undef, 3, 1)

    list[1] = "*DATABASE_SPCFORC"
    
    list[2] = "\$#      dt    binary      lcur     ioopt  "
    fmt = "{:10.6f} {:9d} {:9d} {:9d}"
    list[3]  = format(fmt, dt, binary, lcur, ioopt)

    return list

end

function DATABASE_NODAL_FORCE_GROUP(nsid, cid)

    list = Matrix{String}(undef, 3, 1)

    list[1] = "*DATABASE_NODAL_FORCE_GROUP"
    
    list[2] = "\$#    nsid       cid    "
    fmt = "{:10d} {:9d}"
    list[3]  = format(fmt, nsid, cid)

    return list

end





function DATABASE_NODFOR(dt, binary, lcur, ioopt)

    list = Matrix{String}(undef, 3, 1)

    list[1] = "*DATABASE_NODFOR"
    
    list[2] = "\$#      dt    binary      lcur     ioopt  "
    fmt = "{:10.6f} {:9d} {:9d} {:9d}"
    list[3]  = format(fmt, dt, binary, lcur, ioopt)

    return list

end


function DATABASE_NODOUT(dt, binary, lcur, ioopt, option1, option2)

    list = Matrix{String}(undef, 3, 1)

    list[1] = "*DATABASE_NODOUT"
    
    list[2] = "\$#      dt    binary      lcur     ioopt   option1   option2      "
    fmt = "{:10.6f} {:9d} {:9d} {:9d} {:9.5f} {:9d}"
    list[3]  = format(fmt, dt, binary, lcur, ioopt, option1, option2)

    return list

end




function DEFINE_CURVE_TITLE(title, lcid, sidr, sfa, sfo, offa, offo, dattyp, lcint, curve)


    num_points = length(curve.x)

    list = Matrix{String}(undef, num_points + 5, 1)

    list[1] = "*DEFINE_CURVE_TITLE"
    list[2] = title

    list[3] = "\$#    lcid      sidr       sfa       sfo      offa      offo    dattyp     lcint"
    fmt = "{:10d} {:9d} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9d} {:9d}"
    list[4] = format(fmt, lcid, sidr, sfa, sfo, offa, offo, dattyp, lcint)

    list[5] = "\$#                a1                  o1  "

    fmt = "{:20.5f}{:20.5f}"
    for i = 1:num_points

        list[i+5] = format(fmt, curve.x[i], curve.y[i])

    end

    return list

end


function ELEMENT_SOLID(solid_elements, part_ID)

    #Initialize the element list.
    num_solid_elements = size(solid_elements)[1]
    list = Matrix{String}(undef, num_solid_elements+1, 1)

    #Define the element list formatting.
    fmt = "{:8d} {:7d} {:7d} {:7d} {:7d} {:7d} {:7d} {:7d} {:7d} {:7d}"

    #
    list[1] = "*ELEMENT_SOLID"

    #Fill the element_list vector.
    for i=1:num_solid_elements

        list[i+1] = format(fmt, solid_elements[i,1], part_ID, solid_elements[i,2], solid_elements[i,3],
                            solid_elements[i,4], solid_elements[i,5], solid_elements[i,6], solid_elements[i,7], solid_elements[i,8], solid_elements[i,9])
    end

    return list 

end


function LOAD_NODE_SET(nsid, dof, lcid, sf, cid, m1, m2, m3)

    num_sets = length(nsid)
    
    list = Matrix{String}(undef, num_sets+2, 1)

    list[1] = "*LOAD_NODE_SET"

    list[2] = "\$#    nsid       dof      lcid        sf       cid        m1        m2        m3"

    fmt = "{:10d} {:9d} {:9d} {:9.1f} {:9d} {:9d} {:9d} {:9d}"

    for i = 1:num_sets

        list[i+2] = format(fmt, nsid[i], dof[i], lcid[i], sf[i], cid[i], m1[i], m2[i], m3[i])

    end

    return list

end


function MAT_ELASTIC_TITLE(title, mid, ro, e, pr, da, db)

    list = Matrix{String}(undef, 4, 1)

    list[1] = "*MAT_ELASTIC_TITLE"
    
    list[2] = title
    list[3] = "\$#     mid        ro         e        pr        da        db  not used    "
    fmt = "{:10d} {:9.5e} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f}"
    list[4]  = format(fmt, mid, ro, e, pr, da, db, 0.0)

    return list

end


function MAT_PIECEWISE_LINEAR_PLASTICITY_TITLE(title, mid, ro, e, pr, sigy, etan, fail, tdel, c, p, lcss, lcsr, vp, eps1, eps2, eps3, eps4, eps5, eps6, eps7, eps8, es1, es2, es3, es4, es5, es6, es7, es8)

    list = Matrix{String}(undef, 10, 1)

    list[1] = "*MAT_PIECEWISE_LINEAR_PLASTICITY_TITLE"
    
    list[2] = title
    list[3] = "\$#     mid        ro         e        pr      sigy      etan      fail      tdel"
    fmt = "{:10d}{:9.4E} {:9.1f} {:9.1f} {:9.1f} {:9.1f}{:9.4E} {:9.1f}"
    list[4]  = format(fmt, mid, ro, e, pr, sigy, etan, fail, tdel)

    list[5] = "\$#       c         p      lcss      lcsr        vp  "
    fmt = " {:9.1f} {:9.1f} {:9d} {:9d} {:9.1f}"
    list[6]  = format(fmt, c, p, lcss, lcsr, vp)

    list[7] = "\$#    eps1      eps2      eps3      eps4      eps5      eps6      eps7      eps8 "
    fmt = " {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f}"
    list[8]  = format(fmt, eps1, eps2, eps3, eps4, eps5, eps6, eps7, eps8)

    list[9] = "\$#     es1       es2       es3       es4       es5       es6       es7       es8"
    fmt = " {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f} {:9.1f}"
    list[10]  = format(fmt, es1, es2, es3, es4, es5, es6, es7, es8)

    return list

end


function NODE(nodes)

    #Initialize the node list.
    num_nodes=size(nodes)[1]
    list = Matrix{String}(undef, num_nodes+1, 1)

    list[1] = "*NODE"

    #Define the node list formatting.
    fmt = "{:>8s} {:15.8f} {:15.8f} {:15.8f} {:7d} {:7d}"

    #Fill the node_list vector.
    for i=1:num_nodes
        list[i+1] = format(fmt, string(i), nodes[i, 1], nodes[i, 2], nodes[i, 3], string(0), string(0))
    end

    return list

end


function PART(title, pid, secid, mid, eosid, hgid, grav, adpopt, tmid)

    list = Matrix{String}(undef, 4, 1)

    list[1] = "*PART"
    
    list[2] = title
    list[3] = "\$#     pid     secid       mid     eosid      hgid      grav    adpopt      tmid"
    fmt = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"
    list[4]  = format(fmt, pid, secid, mid, eosid, hgid, grav, adpopt, tmid)

    return list

end


function SECTION_SOLID_TITLE(title, secid, elform, aet, cohoff)

    list = Matrix{String}(undef, 4, 1)

    list[1] = "*SECTION_SOLID_TITLE"
    
    list[2] = title
    list[3] = "\$#   secid    elform       aet    unused    unused    unused    cohoff    unused"
    fmt = "{:10d} {:9d} {:9d} {:39d}"
    list[4]  = format(fmt, secid, elform, aet, cohoff)

    return list

end


function SET_NODE_LIST_TITLE(sid, da1, da2, da3, da4, solver, nodes, title)

    #Define number of nodes in set.
    num_nodes=size(nodes)[1]

    #Figure out the number of rows in the set.
    if (num_nodes/8 - floor(Int, num_nodes/8)) > 0.0  #partial rows

        num_node_rows = floor(Int, num_nodes/8) + 1
        partial_node_num = num_nodes - floor(Int, num_nodes/8) * 8

        partial_node_row = zeros(Int, 8)

        if num_node_rows > 1  #more than one row

            node_list = reshape(nodes[1:(end-partial_node_num)], (num_node_rows-1, 8))
            partial_node_row[1:partial_node_num] = nodes[(end - partial_node_num + 1):end]
            node_list = [node_list; partial_node_row']

        else #only a few nodes, less than 8

            node_list = Matrix{Int64}(undef, (1, 8))
            partial_node_row[1:partial_node_num] = nodes
            node_list[1, :] = partial_node_row  

        end
        
    else  #no partial rows 

        num_node_rows = floor(Int, num_nodes/8)   #all full rows
        node_list = reshape(nodes, (num_node_rows, 8))

    end

    #Define the node set list.  
    list = Matrix{String}(undef, num_node_rows+5, 1)

    #Define first row of node set list.
    fmt_parameter_row = "{:10d} {:9.1f} {:9.1f} {:9.1f} {:9.1f}{:<8s}"

    #Define the node list formatting.
    fmt_node_set = "{:10d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d} {:9d}"

    #Fill the first row of the node_list vector.
    list[1] = "*SET_NODE_LIST_TITLE"
    list[2] = title
    list[3] = "\$#     sid       da1       da2       da3       da4    solver   "
    list[4] = format(fmt_parameter_row, sid, da1, da2, da3, da4, solver)
    list[5] = "\$#    nid1      nid2      nid3      nid4      nid5      nid6      nid7      nid8"

    for i=1:num_node_rows

        list[i+5] = format(fmt_node_set, node_list[i, 1], node_list[i, 2], node_list[i, 3], node_list[i, 4],  node_list[i, 5], node_list[i, 6], node_list[i, 7], node_list[i, 8])

    end
        
    return list
    
end

end #module





