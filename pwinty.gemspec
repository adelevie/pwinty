# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pwinty/version"

Gem::Specification.new do |s|
  s.name        = "pwinty"
  s.version     = Pwinty::VERSION
  s.authors     = ["Alan deLevie"]
  s.email       = ["adelevie@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A Ruby client for the Printy API}
  s.description = %q{Order photo prints with Ruby}

  s.rubyforge_project = "pwinty"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "weary"
  s.add_runtime_dependency "active_attr"
end
