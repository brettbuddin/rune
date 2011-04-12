$LOAD_PATH.unshift 'lib'
require 'rune'

Gem::Specification.new do |s|
  s.name = "rune"
  s.version = Rune::Version

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brett Buddin"]
  s.date = Time.now.strftime("%Y-%m-%d")
  s.summary = %q{Signature generation library for API authentication.}
  s.description = "Signature generation library for API authentication."
  s.email = "brett@intraspirit.net"
  s.homepage = "http://github.com/brettbuddin/rune"

  s.files = [
    "LICENSE",
    "README.md",
    "Rakefile"
  ]
  s.files += Dir.glob("lib/**/*") 
  s.files += Dir.glob("spec/**/*") 
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]

  s.require_paths = ["lib"]
  s.test_files = Dir.glob("spec/**/*")
end
