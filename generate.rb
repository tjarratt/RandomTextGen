require File.dirname(__FILE__) + '/lib/randomtext/text_generator'

if ARGV.length == 0
  script_name = File.basename(__FILE__)
  puts "usage: #{script_name} <seed word> <source file or raw text>
         to generate text using as the seed data, starting with <seed word>"
  puts "example: #{script_name} /path/to/frankenstein.txt"
  puts "example: #{script_name} hello world i am a simple robot. would you like to play a game?"
  exit 1
end

seed_text = nil

if ARGV.length == 1
  seed_text = File.open(File.join(File.dirname(__FILE__), ARGV[0])) { |f| f.read }
else
  seed_text = ARGV.join(' ')
end

words = seed_text.split(' ')
seed = words.at(Random.rand(words.length)).gsub(/[^A-Za-z]/, '')

puts "generating from seed #{seed} with a body of size #{words.length}"

puts RandomText::TextGenerator.new.seed(seed_text).generate(seed)
