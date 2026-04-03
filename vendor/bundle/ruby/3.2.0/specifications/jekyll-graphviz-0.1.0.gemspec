# -*- encoding: utf-8 -*-
# stub: jekyll-graphviz 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "jekyll-graphviz".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Keiichiro Ui".freeze]
  s.bindir = "exe".freeze
  s.date = "2015-12-27"
  s.email = ["keiichiro.ui@gmail.com".freeze]
  s.homepage = "https://github.com/kui/jekyll-graphviz".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.20".freeze
  s.summary = "A liquid tag to convert with Graphviz for Jekyll".freeze

  s.installed_by_version = "3.4.20" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<jekyll>.freeze, [">= 2.0"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
  s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
end
