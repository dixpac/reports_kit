require File.expand_path('../lib/reports_kit/version', __FILE__)

Gem::Specification.new do |s|
  s.authors       = ['Tom Benner']
  s.email         = ['tombenner@gmail.com']
  s.description = s.summary = %q{ReportsKit}
  s.homepage      = 'https://github.com/tombenner/reports_kit'

  s.files         = `git ls-files`.split($\)
  s.name          = 'reports_kit'
  s.require_paths = ['lib']
  s.version       = ReportsKit::VERSION
  s.license       = 'MIT'

  s.add_dependency 'rails'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.0'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'timecop'
end