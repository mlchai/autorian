# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jdbc-sqlite3"
  s.version = "3.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nick Sieger, Ola Bini and JRuby contributors"]
  s.date = "2011-06-16"
  s.description = "Install this gem and require 'sqlite3' within JRuby to load the driver."
  s.email = "nick@nicksieger.com, ola.bini@gmail.com"
  s.extra_rdoc_files = ["Manifest.txt", "README.txt", "LICENSE.txt"]
  s.files = ["Manifest.txt", "README.txt", "LICENSE.txt"]
  s.homepage = "http://jruby-extras.rubyforge.org/ActiveRecord-JDBC"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "jruby-extras"
  s.rubygems_version = "1.8.24"
  s.summary = "SQLite3 JDBC driver for Java and SQLite3/ActiveRecord-JDBC."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
