require 'rubocop/rake_task'

RuboCop::RakeTask.new

task :default => [:test, :rubocop]
task :test do
    ruby "./test/test.rb"
end
