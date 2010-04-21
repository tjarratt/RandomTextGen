require File.dirname(__FILE__) + '/weighted_directed_graph'

class MarkovChain
  attr_accessor :graph
  
  def initialize
    @graph = WeightedDirectedGraph.new
  end
  
  def increment_probability(a,b)
    @graph.add_nodes([a,b])#does nothing if either already exists 
    
    current_weight = @graph.edge_weight(a,b)
    current_weight = current_weight + 1
    
    @graph.connect(a,b, current_weight)
  end   
  
  def next_point(point)
    choices = @graph.node(point).values
    sum = choices.inject(0) { |result, value| result + value}
    sum = sum*rand
    #without *rand this would be a little too deterministic
    #we can ensure that even a choice with weight 1 will be choosen 
    
    tmp = 0          
    @graph.node(point).each{ |option, value|
      tmp = tmp + value
      if tmp > sum
        return option 
      end
    }
  end

  def random_walk(start)
    sentence = []
    here = start.downcase
    
    sentence << here
    
    while @graph.out_degree_of(here) > 0
      here = next_point(here)
      sentence << here         
    end
    return sentence
  end

end