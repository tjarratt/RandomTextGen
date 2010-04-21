require File.dirname(__FILE__) + '/markov_chain'

class TextGenerator
  attr_reader :markov_chain
  
  def initialize 
    @markov_chain = MarkovChain.new
  end
  
  def seed(text)      
    #things to consider
    #white space
    #punctuation ,.!?#[]***()
    #urls?
    #numbers
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
  end
  
  def sentences(text)     
    sentences = text.split(/\.|\?|\!/).each{ |aSentence|
      aSentence.gsub!(/\n|\r|\t|\v|\f|\e/, ' ') #white space, to single space
    }
    sentences.delete_if{|aSentence| aSentence == nil | !aSentence.match(/\S/)}
    sentences.each{|sentence| sentence.strip!}
    return sentences
  end
  
  def generate(start)
    seedWord = start.downcase
    @markov_chain.random_walk(seedWord).join(" ").capitalize.chomp << '.'
    #a long one-liner here better than putting sentence joining logic in markov_chain.rb
  end
  
end