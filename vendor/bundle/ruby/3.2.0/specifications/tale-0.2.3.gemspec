# -*- encoding: utf-8 -*-
# stub: tale 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "tale".freeze
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chester How".freeze]
  s.date = "2021-05-03"
  s.email = ["chesterhow@gmail.com".freeze]
  s.homepage = "https://github.com/chesterhow/tale".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.20".freeze
  s.summary = "Tale is a minimal Jekyll theme curated for storytellers.".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<jekyll>.freeze, ["~> 4.0"])
  s.add_runtime_dependency(%q<jekyll-paginate>.freeze, ["~> 1.1"])
  s.add_runtime_dependency(%q<jekyll-feed>.freeze, ["~> 0.10"])
  s.add_runtime_dependency(%q<jekyll-seo-tag>.freeze, ["~> 2.5"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.0"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 12.3.3"])
end
