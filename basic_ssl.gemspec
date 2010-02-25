Gem::Specification.new do |s|
  s.name = 'basic_ssl'
  s.version = "1.0.2"
  s.platform = Gem::Platform::RUBY
  s.summary = "Basic encryption and signing wrapper"
  
  s.files = Dir.glob("{lib}/**/*")
  s.require_path = 'lib'
  s.has_rdoc = false

  s.author = "Adam Cooke"
  s.email = "adam@atechmedia.com"
  s.homepage = "http://github.com/adamcooke/basicssl"
end
