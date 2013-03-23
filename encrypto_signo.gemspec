Gem::Specification.new do |s|
  s.name = 'encrypto_signo'
  s.version = "1.0.0"
  s.platform = Gem::Platform::RUBY
  s.summary = "Basic encryption and signing library for Ruby"
  
  s.files = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
  s.has_rdoc = false

  s.author = "Adam Cooke"
  s.email = "adam@atechmedia.com"
  s.homepage = "http://atechmedia.com"
end
