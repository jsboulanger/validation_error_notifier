# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name        = 'validation_error_notifier'
  gem.version     = '0.0.1'
  gem.description = 'A notifier for form validation errors.'
  gem.authors     = ['Jean-Sebastien Boulanger']
  gem.email       = ['jsboulanger@gmail.com']
  gem.summary     = gem.description
  gem.homepage    = 'http://github.com/jsboulanger/validation_error_notifier'
  gem.license     = "MIT"

  gem.require_path = 'lib'

  gem.add_dependency "actionmailer", ">=3.0"
  gem.add_development_dependency "rails", ">= 3.0"
  gem.add_development_dependency "sqlite3", ">= 1.3"
  gem.add_development_dependency 'rake'
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rspec-rails"
end
