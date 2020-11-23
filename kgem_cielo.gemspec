require './lib/cielo/version'

Gem::Specification.new do |s|
  s.name          = "kgem_cielo"
  s.version       = KCielo::VERSION
  s.description   = "Cielo API REST que funciona no ruby 1.8 e atende as necessidades especiais da Komeia"
  s.summary       = "API Pagamentos"
  s.author        = "Komeia"
  s.files         = Dir["{lib/**/*.rb,*.gemspec,README,Gemfile,lib/**/*.pem}"]
  s.require_paths = ["lib"]

  # s.add_dependency "kgem_log"
  s.add_dependency 'json_pure', '~> 1.6', '<= 1.6.4'
  s.add_dependency 'rake', '>= 0.8.7'

  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")

  s.post_install_message = "****\nPara alterar as configurações default da gem leia o README localizado no root path da gem\n****"
end
