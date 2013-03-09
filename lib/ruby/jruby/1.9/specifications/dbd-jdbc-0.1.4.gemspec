# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "dbd-jdbc"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chad Johnson"]
  s.date = "2009-12-02"
  s.description = "A JDBC DBD driver for Ruby DBI"
  s.email = "chad.j.johnson@gmail.com"
  s.extra_rdoc_files = ["README.txt"]
  s.files = ["README.txt"]
  s.homepage = "http://kenai.com/projects/dbd-jdbc"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "jruby-extras"
  s.rubygems_version = "1.8.24"
  s.summary = "JDBC driver for DBI, originally by Kristopher Schmidt and Ola Bini"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
