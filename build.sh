clang -shared -fpic -O3 instrument.c -o instrument.so
clang -I. -Ilib -Ilib/cdt -Ilib/pack -Ilib/label -Ilib/common -Ilib/ortho -Ilib/xdot -Ilib/cgraph -Ilib/pathplan -Ilib/gvc -Ilib/dotgen -Ilib/ast -Ilib/expr -Ilib/gvpr -Ilib/ingraphs -Ilib/sfio -Ilib/vmalloc -Iplugin/core -Iinclude -DGVLIBDIR=\"$PWD/bin\" -DDEMAND_LOADING=1 lib/cgraph/agerror.c lib/cgraph/apply.c lib/cgraph/attr.c lib/cgraph/edge.c lib/cgraph/graph.c lib/cgraph/grammar.c lib/cgraph/id.c lib/cgraph/imap.c lib/cgraph/io.c lib/cgraph/mem.c lib/cgraph/node.c lib/cgraph/obj.c lib/cgraph/rec.c lib/cgraph/refstr.c lib/cgraph/scan.c lib/cgraph/subg.c lib/cgraph/utils.c lib/cgraph/write.c lib/cdt/dtclose.c lib/cdt/dtdisc.c lib/cdt/dtextract.c lib/cdt/dtflatten.c lib/cdt/dthash.c lib/cdt/dtlist.c lib/cdt/dtmethod.c lib/cdt/dtopen.c lib/cdt/dtrenew.c lib/cdt/dtrestore.c lib/cdt/dtsize.c lib/cdt/dtstat.c lib/cdt/dtstrhash.c lib/cdt/dttree.c lib/cdt/dtview.c lib/cdt/dtwalk.c lib/gvc/gvrender.c lib/gvc/gvlayout.c lib/gvc/gvdevice.c lib/gvc/gvloadimage.c lib/gvc/gvcontext.c lib/gvc/gvjobs.c lib/gvc/gvevent.c lib/gvc/gvplugin.c lib/gvc/gvconfig.c lib/gvc/gvtool_tred.c lib/gvc/gvtextlayout.c lib/gvc/gvusershape.c lib/gvc/gvc.c lib/pathplan/cvt.c lib/pathplan/inpoly.c lib/pathplan/route.c lib/pathplan/shortest.c lib/pathplan/shortestpth.c lib/pathplan/solvers.c lib/pathplan/triang.c lib/pathplan/util.c lib/pathplan/visibility.c lib/pack/ccomps.c lib/pack/pack.c lib/label/xlabels.c lib/label/index.c lib/label/node.c lib/label/rectangle.c lib/label/split.q.c lib/common/arrows.c lib/common/colxlate.c lib/common/ellipse.c lib/common/textspan.c lib/common/textspan_lut.c lib/common/args.c lib/common/memory.c lib/common/globals.c lib/common/htmllex.c lib/common/htmltable.c lib/common/htmlparse.c lib/common/input.c lib/common/pointset.c lib/common/intset.c lib/common/postproc.c lib/common/routespl.c lib/common/splines.c lib/common/psusershape.c lib/common/timing.c lib/common/labels.c lib/common/ns.c lib/common/shapes.c lib/common/utils.c lib/common/geom.c lib/common/taper.c lib/common/output.c lib/common/emit.c lib/common/xml.c lib/ortho/fPQ.c lib/ortho/maze.c lib/ortho/ortho.c lib/ortho/partition.c lib/ortho/rawgraph.c lib/ortho/sgraph.c lib/ortho/trapezoid.c lib/xdot/xdot.c lib/dotgen/acyclic.c lib/dotgen/class1.c lib/dotgen/class2.c lib/dotgen/cluster.c lib/dotgen/compound.c lib/dotgen/conc.c lib/dotgen/decomp.c lib/dotgen/fastgr.c lib/dotgen/flat.c lib/dotgen/dotinit.c lib/dotgen/mincross.c lib/dotgen/position.c lib/dotgen/rank.c lib/dotgen/sameport.c lib/dotgen/dotsplines.c lib/dotgen/aspect.c lib/ast/pathpath.c lib/ast/chresc.c lib/ast/chrtoi.c lib/ast/error.c lib/ast/fmtbuf.c lib/ast/fmtesc.c lib/ast/pathaccess.c lib/ast/pathcanon.c lib/ast/pathcat.c lib/ast/pathfind.c lib/ast/strcopy.c lib/ast/stresc.c lib/ast/strmatch.c lib/expr/excc.c lib/expr/excontext.c lib/expr/exdata.c lib/expr/exerror.c lib/expr/exeval.c lib/expr/exexpr.c lib/expr/exopen.c lib/expr/extoken.c lib/expr/extype.c lib/expr/exzero.c lib/expr/exnospace.c lib/expr/exparse.c lib/gvpr/actions.c lib/gvpr/compile.c lib/gvpr/gvpr.c lib/gvpr/gprstate.c lib/gvpr/parse.c lib/gvpr/queue.c lib/ingraphs/ingraphs.c lib/sfio/sfcvt.c lib/sfio/sfextern.c lib/sfio/sfprint.c lib/sfio/sfscanf.c lib/sfio/sftable.c lib/sfio/sfvscanf.c lib/sfio/Sfio_f/_sfslen.c lib/vmalloc/vmalloc.c lib/vmalloc/vmclear.c lib/vmalloc/vmclose.c lib/vmalloc/vmopen.c lib/vmalloc/vmstrdup.c lib/neatogen/adjust.c lib/neatogen/circuit.c lib/neatogen/edges.c lib/neatogen/geometry.c lib/neatogen/heap.c lib/neatogen/hedges.c lib/neatogen/info.c lib/neatogen/neatoinit.c lib/neatogen/legal.c lib/neatogen/lu.c lib/neatogen/matinv.c lib/neatogen/memory.c lib/neatogen/poly.c lib/neatogen/printvis.c lib/neatogen/site.c lib/neatogen/solve.c lib/neatogen/neatosplines.c lib/neatogen/stuff.c lib/neatogen/voronoi.c lib/neatogen/stress.c lib/neatogen/kkutils.c lib/neatogen/matrix_ops.c lib/neatogen/embed_graph.c lib/neatogen/dijkstra.c lib/neatogen/conjgrad.c lib/neatogen/pca.c lib/neatogen/closest.c lib/neatogen/bfs.c lib/neatogen/constraint.c lib/neatogen/quad_prog_solve.c lib/neatogen/smart_ini_x.c lib/neatogen/constrained_majorization.c lib/neatogen/opt_arrangement.c lib/neatogen/overlap.c lib/neatogen/call_tri.c lib/neatogen/compute_hierarchy.c lib/neatogen/delaunay.c lib/neatogen/multispline.c lib/neatogen/sgd.c lib/neatogen/randomkit.c lib/neatogen/constrained_majorization_ipsep.c lib/neatogen/quad_prog_vpsc.c lib/fdpgen/comp.c lib/fdpgen/dbg.c lib/fdpgen/grid.c lib/fdpgen/fdpinit.c lib/fdpgen/layout.c lib/fdpgen/tlayout.c lib/fdpgen/xlayout.c lib/fdpgen/clusteredges.c lib/sfdpgen/sfdpinit.c lib/sfdpgen/spring_electrical.c lib/sfdpgen/sparse_solve.c lib/sfdpgen/post_process.c lib/sfdpgen/stress_model.c lib/sfdpgen/Multilevel.c lib/twopigen/circle.c lib/twopigen/twopiinit.c lib/circogen/circularinit.c lib/circogen/nodelist.c lib/circogen/block.c lib/circogen/edgelist.c lib/circogen/circular.c lib/circogen/blocktree.c lib/circogen/blockpath.c lib/circogen/circpos.c lib/patchwork/patchwork.c lib/patchwork/patchworkinit.c lib/patchwork/tree_map.c lib/osage/osageinit.c lib/sparse/SparseMatrix.c lib/sparse/general.c lib/sparse/BinaryHeap.c lib/sparse/DotIO.c lib/sparse/LinkedList.c lib/sparse/colorutil.c lib/sparse/color_palette.c lib/sparse/mq.c lib/sparse/clustering.c lib/sparse/QuadTree.c lib/vpsc/block.cpp lib/vpsc/blocks.cpp lib/vpsc/constraint.cpp lib/vpsc/generate-constraints.cpp lib/vpsc/pairingheap/PairingHeap.cpp lib/vpsc/solve_VPSC.cpp lib/vpsc/csolve_VPSC.cpp lib/vpsc/variable.cpp lib/vpsc/pairingheap/PairingHeap.cpp plugin/core/gvplugin_core.c plugin/core/gvrender_core_dot.c plugin/core/gvrender_core_json.c plugin/core/gvrender_core_fig.c plugin/core/gvrender_core_map.c plugin/core/gvrender_core_mp.c plugin/core/gvrender_core_ps.c plugin/core/gvrender_core_svg.c plugin/core/gvrender_core_tk.c plugin/core/gvrender_core_pov.c plugin/core/gvrender_core_pic.c plugin/core/gvloadimage_core.c plugin/dot_layout/gvlayout_dot_layout.c plugin/dot_layout/gvplugin_dot_layout.c plugin/gd/gvdevice_gd.c plugin/gd/gvloadimage_gd.c plugin/gd/gvplugin_gd.c plugin/gd/gvrender_gd.c plugin/gd/gvrender_gd_vrml.c plugin/gd/gvtextlayout_gd.c plugin/neato_layout/gvlayout_neato_layout.c plugin/neato_layout/gvplugin_neato_layout.c cmd/dot/dot.c cmd/dot/dot_builtins.cpp $PWD/instrument.so -finstrument-functions-after-inlining -rdynamic -O3 -Llib -lm -ldl -lz -lltdl -lexpat -lgd -lstdc++ -o dot

