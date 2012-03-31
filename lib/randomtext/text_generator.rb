require File.expand_path 'markov_chain', File.dirname(__FILE__)

module RandomText
  class TextGenerator
    attr_reader :markov_chain

    def initialize
      @markov_chain = RandomText::MarkovChain.new
    end

    def seed(text)
      sentences(text).each{ |aSentence|
        words = aSentence.split
        words.each{ |aWord|
          aWord.gsub!(/\d|,|;|:|-|"|'|\*|[0-9]|http:\/\//, '')
        }.delete_if{ |aWord| aWord == nil | aWord.empty?}

        words.each_with_index{ |aWord, idx|
          next_word = words[idx + 1]

          if next_word
            @markov_chain.increment_probability(aWord.downcase.strip,next_word.downcase.strip)
          end
        }
      }
      self
    end

    def sentences(text)
      sentences = text.split(/\.|\?|\!/).each{ |aSentence|
        aSentence.gsub!(/\n|\r|\t|\v|\f|\e/, ' ')
      }
      return sentences.delete_if { |aSentence| aSentence == nil | !aSentence.match(/\S/) }.each { |s| s.strip }
    end

    def generate(start)
      @markov_chain.random_walk(start.downcase).join(" ").capitalize.chomp << '.'
    end
  end
end
