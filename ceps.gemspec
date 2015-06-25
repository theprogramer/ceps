# -*- enconding: utf-8 -*-

require File.expand_path('../lib/ceps/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Thiago Miranda']
  gem.email         = ['theprogramer@theprogramer.com.br']
  gem.description   = 'All sorts of useful information about every brazilian cep packaged as pretty little cep objects.'
  gem.summary       = 'Gives you a cep object full of all sorts of useful information.'
  gem.homepage      = 'http://github.com/theprogramer/ceps'

  gem.files         = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'ceps'
  gem.require_paths = ['lib']
  gem.version       = Ceps::VERSION

  gem.add_development_dependency('rspec', '>= 3')
end
