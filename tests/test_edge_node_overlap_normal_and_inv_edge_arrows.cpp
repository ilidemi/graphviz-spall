#include <string>

#include <catch2/catch.hpp>

#include "test_edge_node_overlap_utilities.h"
#include "test_utilities.h"

TEST_CASE("Edge node overlap for normal and inv arrow",
          "[!shouldfail] An edge connected to a node shall touch that node and "
          "not overlap it too much, regardless of if the arrow shape is "
          "'normal' or 'inv'") {

  std::string filename_base = "test_edge_node_overlap_all_edge_arrows";

  const std::string_view primitive_arrow_shape = GENERATE("normal", "inv");

  INFO(fmt::format("Edge arrowhead: {}", primitive_arrow_shape));
  filename_base += fmt::format("_arrow_shape_{}", primitive_arrow_shape);

  const graph_options graph_options = {
      .node_shape = "polygon",
      .node_penwidth = 2,
      .dir = "both",
      .edge_penwidth = 2,
      .primitive_arrowhead_shape = primitive_arrow_shape,
      .primitive_arrowtail_shape = primitive_arrow_shape,
  };

  test_edge_node_overlap(graph_options, {}, {.filename_base = filename_base});
}