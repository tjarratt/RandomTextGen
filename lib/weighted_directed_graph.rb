class WeightedDirectedGraph
  
  def initialize
    @points = Hash.new  
  end
  
  def node(name)
    @points[name]
  end    
  
  def add_node(name)
    if !contains?(name)
      @points[name] = Hash.new
    end
  end
  
  def add_nodes(names)
    names.each{|aName|
      add_node(aName)
    }#convenience
  end
  
  def connect(a,b,weight=1)
    @points[a][b] = weight
  end
  
  def edge_weight(a,b)
    weight = @points[a][b]? @points[a][b] : 0
    return weight
  end
  
  def contains?(name)
    return @points[name]? true:false
  end
  
  def out_degree_of(name)
    return @points[name]? @points[name].length : 0
  end
  
end