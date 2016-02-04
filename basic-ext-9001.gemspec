require 'basic-ext-9001/version'

Gem::Specification.new do |s|
  s.name = 'basic-ext-9001'
  s.version = BasicExt9001::Version
  s.authors = ['Joseph Tibbertsma']
  s.summary = "First ruby c extension"
  s.description = "I've been looking into how to write ruby c extensions lately, so I want make an extension gem that I can experiment on. That's what this is."
  s.email = 'josephtibbertsma@gmail.com'
  s.extensions = ['ext/the_guts/extconf.rb']
  s.license = 'none lol'
  s.homepage = 'http://github.com/jtibbertsma/basic-ext-9001'
  s.files = Dir['{ext/**/*,lib/**/*}'] + %w(basic-ext-9001.gemspec Rakefile readme.md)
  s.test_files = Dir['{spec/**/*}']
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rake-compiler'
  s.add_development_dependency 'rspec'
end