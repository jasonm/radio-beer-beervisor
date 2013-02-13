exports.ForceDiagram = function(nodes, links) {
  var width = document.width,
      height = document.height;

  var color = d3.scale.category20();

  var svg = d3.select("body").append("svg")
      .attr("width", width)
      .attr("height", height);

  var force = d3.layout.force()
      .charge(-180)
      .linkDistance(80)
      .size([width, height]);

  this.nodes = nodes;
  this.links = links;

  force
      .nodes(this.nodes)
      .links(this.links)
      .start();

  var link = svg.selectAll(".link");
  var node = svg.selectAll(".node");

  this.update = function() {
    console.log("updating...")

  //   link = link.data(force.links(), function(d) { return d.source.id + "-" + d.target.id; });
  // link.enter().insert("line", ".node").attr("class", "link");
  // link.exit().remove();
 
  // node = node.data(force.nodes(), function(d) { return d.id;});
  // node.enter().append("circle").attr("class", function(d) { return "node " + d.id; }).attr("r", 8);
  // node.exit().remove();

    link = link.data(force.links());
    link.enter().append("line").attr("class", "link");
    link.exit().remove();

    node = node.data(force.nodes());
    node.enter().append("g")
      .attr("class", "node")
      .call(force.drag);
    node.exit().remove();

    node.append("circle")
      .attr("r", 10)
      .style("fill", function(d) { return color(d.group); });

    node.append("title")
      .text(function(d) { return d.name; });

    node.append("text")
      .attr("dx", 12)
      .attr("dy", ".35em")
      // .text(function(d) { return d.name });
      .text(function(d) { return  ['', 'Reader', 'Tag'][d.group] + ": " + d.name });

  }

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
  });

  console.log("inside ctor");
  this.update();

  return this;
}
