# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{odiseo}
  s.version = "0.7.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["AP System"]
  s.date = %q{2011-09-01}
  s.description = %q{Adminsitracion de contabilidad}
  s.email = %q{info@ap-sys.com.ar}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "app/controllers/accounts_controller.rb",
    "app/controllers/entries_controller.rb",
    "app/controllers/exercises_controller.rb",
    "app/controllers/odiseo/balance_reports_controller.rb",
    "app/controllers/odiseo/general_balance_reports_controller.rb",
    "app/controllers/odiseo/report_dates_controller.rb",
    "app/controllers/odiseo/reports_controller.rb",
    "app/helpers/accounts_helper.rb",
    "app/helpers/entries_helper.rb",
    "app/helpers/exercises_helper.rb",
    "app/helpers/odiseo/balance_reports_helper.rb",
    "app/helpers/odiseo/general_balance_reports_helper.rb",
    "app/helpers/odiseo/report_dates_helper.rb",
    "app/helpers/odiseo/reports_helper.rb",
    "app/models/account.rb",
    "app/models/detail.rb",
    "app/models/entry.rb",
    "app/models/exercise.rb",
    "app/models/odiseo/balance_report.rb",
    "app/models/odiseo/general_balance_report.rb",
    "app/models/odiseo/report.rb",
    "app/models/odiseo/report_date.rb",
    "app/views/accounts/_account.html.haml",
    "app/views/accounts/_form.html.haml",
    "app/views/accounts/edit.html.haml",
    "app/views/accounts/index.html.haml",
    "app/views/accounts/new.html.haml",
    "app/views/accounts/show.html.haml",
    "app/views/entries/_detail_fields.html.haml",
    "app/views/entries/_form.html.haml",
    "app/views/entries/edit.html.haml",
    "app/views/entries/index.html.haml",
    "app/views/entries/new.html.haml",
    "app/views/entries/show.html.haml",
    "app/views/exercises/_form.html.haml",
    "app/views/exercises/edit.html.haml",
    "app/views/exercises/from_date.html.haml",
    "app/views/exercises/index.html.haml",
    "app/views/exercises/new.html.haml",
    "app/views/exercises/show.html.haml",
    "app/views/odiseo/balance_reports/_form.html.haml",
    "app/views/odiseo/balance_reports/new.html.haml",
    "app/views/odiseo/general_balance_reports/_form.html.haml",
    "app/views/odiseo/general_balance_reports/new.html.haml",
    "app/views/odiseo/report_dates/_form.html.haml",
    "app/views/odiseo/report_dates/new.html.haml",
    "app/views/odiseo/reports/_form.html.haml",
    "app/views/odiseo/reports/new.html.haml",
    "config/routes.rb",
    "lib/odiseo.rb",
    "lib/odiseo/engine.rb",
    "odiseo.gemspec",
    "spec/controllers/odiseo/reports_controller_spec.rb",
    "spec/helpers/odiseo/reports_helper_spec.rb",
    "spec/odiseo_spec.rb",
    "spec/requests/odiseo/odiseo_reports_spec.rb",
    "spec/routing/odiseo/reports_routing_spec.rb",
    "spec/spec_helper.rb",
    "spec/views/odiseo/reports/new.html.haml_spec.rb",
    "spec/views/odiseo/reports/show.html.haml_spec.rb"
  ]
  s.homepage = %q{http://github.com/lguardiola/odiseo}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{Proyecto Contable}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml-rails>, [">= 0"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_runtime_dependency(%q<cocoon>, [">= 0"])
      s.add_runtime_dependency(%q<formtastic>, [">= 0"])
      s.add_runtime_dependency(%q<attrtastic>, [">= 0"])
      s.add_runtime_dependency(%q<kaminari>, [">= 0"])
      s.add_runtime_dependency(%q<nested_set>, [">= 0"])
      s.add_runtime_dependency(%q<meta_search>, [">= 0"])
      s.add_runtime_dependency(%q<meta_where>, [">= 0"])
      s.add_runtime_dependency(%q<prawn>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<haml-rails>, [">= 0"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<cocoon>, [">= 0"])
      s.add_dependency(%q<formtastic>, [">= 0"])
      s.add_dependency(%q<attrtastic>, [">= 0"])
      s.add_dependency(%q<kaminari>, [">= 0"])
      s.add_dependency(%q<nested_set>, [">= 0"])
      s.add_dependency(%q<meta_search>, [">= 0"])
      s.add_dependency(%q<meta_where>, [">= 0"])
      s.add_dependency(%q<prawn>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<haml-rails>, [">= 0"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<cocoon>, [">= 0"])
    s.add_dependency(%q<formtastic>, [">= 0"])
    s.add_dependency(%q<attrtastic>, [">= 0"])
    s.add_dependency(%q<kaminari>, [">= 0"])
    s.add_dependency(%q<nested_set>, [">= 0"])
    s.add_dependency(%q<meta_search>, [">= 0"])
    s.add_dependency(%q<meta_where>, [">= 0"])
    s.add_dependency(%q<prawn>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

