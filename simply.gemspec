# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{simply}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Taylor"]
  s.date = %q{2009-05-07}
  s.description = %q{TODO}
  s.email = %q{scott@railsnewbie.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "Rakefile",
    "VERSION.yml",
    "lib/simply.rb",
    "lib/simply/html_builder.rb",
    "lib/simply/html_tags.rb",
    "lib/simply/indentation.rb",
    "lib/simply/locals.rb",
    "lib/simply/version.rb",
    "spec/simply/html_builder/indentation_spec.rb",
    "spec/simply/html_builder/locals_spec.rb",
    "spec/simply/html_builder_spec.rb",
    "spec/simply/indentation_spec.rb",
    "spec/simply/simply_spec.rb",
    "spec/simply/version_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/smtlaissezfaire/simply}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "spec/simply/html_builder/indentation_spec.rb",
    "spec/simply/html_builder/locals_spec.rb",
    "spec/simply/html_builder_spec.rb",
    "spec/simply/indentation_spec.rb",
    "spec/simply/simply_spec.rb",
    "spec/simply/version_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
