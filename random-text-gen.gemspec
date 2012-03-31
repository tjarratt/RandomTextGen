Gem::Specification.new do |s|
  s.name = 'random-text-gen'
  s.version = 1.1
  s.authors = ['Tim Jarratt']
  s.email = ['tjarratt@gmail.com']
  s.homepage = 'http://github.com/tjarratt/RandomTextGen'
  s.summary = 'Create a random string from a body of text.'

  s.require_path = 'lib'
  s.files = Dir.glob('lib/**/*') + %w{LICENSE README}
end
