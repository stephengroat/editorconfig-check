require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %w(test rubocop)
task :test do
  ruby './test/test.rb'
end
