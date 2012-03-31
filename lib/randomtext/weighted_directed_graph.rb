module RandomText
end

class RandomText::WeightedDirectedGraph
  def initialize
    @points = Hash.new
  end

  def node(name)
    @points[name]
  end

  def add_node(name)
    @points[name] = Hash.new unless contains?(name)
  end

  def add_nodes(names)
    names.each { |aName| add_node(aName) }
  end

  def connect(a,b,weight=1)
    @points[a][b] = weight
  end

  def edge_weight(a,b)
    @points[a][b]? @points[a][b] : 0
  end

  def contains?(name)
    @points[name] ? true : false
  end

  def out_degree_of(name)
    @points[name] ? @points[name].length : 0
  end
end
