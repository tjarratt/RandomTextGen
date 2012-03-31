require File.expand_path 'weighted_directed_graph', File.dirname(__FILE__)

module RandomText
  class RandomText::MarkovChain
    attr_accessor :graph

    def initialize
      @graph = RandomText::WeightedDirectedGraph.new
    end

    def increment_probability(a,b)
      @graph.add_nodes([a,b])

      current_weight = @graph.edge_weight(a,b)
      current_weight = current_weight + 1

      @graph.connect(a,b, current_weight)
    end

    def next_point(point)
      choices = @graph.node(point).values
      sum = choices.inject(0) { |result, value| result + value}
      sum = sum*rand

      tmp = 0
      @graph.node(point).each do |option, value|
        tmp = tmp + value
        if tmp > sum
          return option
        end
      end
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
end
