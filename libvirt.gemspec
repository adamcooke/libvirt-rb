# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "libvirt/version"

Gem::Specification.new do |s|
  s.name        = "libvirt"
  s.version     = Libvirt::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = "http://rubygems.org/gems/libvirt"
  s.summary     = "A ruby client library providing the raw interface to libvirt via FFI."
  s.description = "A ruby client library providing the raw interface to libvirt via FFI."

  s.rubyforge_project = "libvirt"

  s.add_dependency "ffi", "~> 0.6.3"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end