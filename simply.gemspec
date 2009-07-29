# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{simply}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Taylor"]
  s.date = %q{2009-07-29}
  s.description = %q{A minimal markaby-esq ruby templating language}
  s.email = %q{scott@railsnewbie.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".gitignore",
     "README",
     "Rakefile",
     "VERSION.yml",
     "benchmarks/001_7a22450a80d6253bf9f0aabb2ee0110c2d67c8a6.out",
     "benchmarks/002_e462499cd6bd8dface62e433311b3bc0b0b55a42",
     "benchmarks/003_fd604401b1b03096ec35cdb3036821b92a71791b.out",
     "benchmarks/004_b75e031f96b342559036444f502d44da7e7104f0.out",
     "benchmarks/comparison.rb",
     "lib/simply.rb",
     "lib/simply/escaping.rb",
     "lib/simply/html_builder.rb",
     "lib/simply/html_tags.rb",
     "lib/simply/indentation.rb",
     "lib/simply/locals.rb",
     "lib/simply/version.rb",
     "profiling/run_static.rb",
     "profiling/run_static_001_0e246c3de41a891c206c8cb5a552d17d78e4b8ec.out",
     "reference/ABOUT",
     "reference/xhtml1-frameset.xsd",
     "reference/xhtml1-strict.xsd",
     "reference/xhtml1-transitional.xsd",
     "simply.gemspec",
     "spec/simply/html_builder/indentation_spec.rb",
     "spec/simply/html_builder/locals_spec.rb",
     "spec/simply/html_builder_spec.rb",
     "spec/simply/indentation_spec.rb",
     "spec/simply/simply_spec.rb",
     "spec/simply/version_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/smtlaissezfaire/simply}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{A minimal markaby-esq ruby templating language}
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
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
