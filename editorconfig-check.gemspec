#require_relative "lib/editorconfig-check/version"

Gem::Specification.new do |s|
  s.name = "editorconfig-check"
#  s.version = EditorConfig::VERSION
   s.version = "0.1"
  s.summary = "EditorConfig check library written in Ruby"
  s.license = "MIT"
  s.authors = "GitHub"
  s.homepage = "https://github.com/stephengroat/editorconfig-check"

  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "rake", "~> 10.0"

  s.files = [
    #"lib/editor_config/version.rb",
    "lib/editorconfig-check.rb"
  ]
end
