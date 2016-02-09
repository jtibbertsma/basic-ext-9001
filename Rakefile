require "rake/extensiontask"

Rake::ExtensionTask.new "the_guts" do |ext|
  ext.lib_dir = "lib/basic-ext-9001"
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
  task :spec => :compile
rescue LoadError
  # no rspec available
end