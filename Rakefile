#!/usr/bin/env rake
require 'bundler/gem_tasks'

require 'rake'
require 'rspec/core/rake_task'

desc 'Run all examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = %w(--color --warnings)
end

task default: [:spec]


desc 'Import MDB file'
task :import do

  require 'mdb'
  require 'yaml'
  require_relative 'lib/ceps/mdb'
  require 'ruby-progressbar'

  db = Mdb.open ARGV[1]
  puts "Loading routes"
  puts "This should take some time!"
  routes = db["LOG_LOGRADOURO"]
  puts "Loading neighborhoods"
  neighborhoods = db["LOG_BAIRRO"]
  puts "Loading cities"
  cities = db["LOG_LOCALIDADE"]
  puts "Loading states"
  states = db["LOG_FAIXA_UF"]
  
  ceps = {}
  puts "Generating new hash"
  progressbar = ProgressBar.create title: "Progress",
                                   starting_at: 0,
                                   total: routes.count,
                                   format: "%c from %C |%b>>%i| %a (%e) %p%%"
  routes.each do |route|
    cep = Correios::Mdb.decript route[:LOG_KEY_DNE]
    ceps[cep.to_sym] = {
      location: route[:LOG_NO],
      type: route[:LOG_TIPO_LOGRADOURO],
      city: cities.select{|c| c[:LOC_NU_SEQUENCIAL] == route[:LOC_NU_SEQUENCIAL].to_s}.first[:LOC_NO],
      state: states.select{|s| s[:UFE_SG] == route[:UFE_SG]}.first[:UFE_NO],
      neighborhood: neighborhoods.select{|n| n[:BAI_NU_SEQUENCIAL] == route[:BAI_NU_SEQUENCIAL_INI].to_s}.first[:BAI_NO]
    }
    progressbar.increment
    progressbar.refresh
  end
  puts "Saving new ceps.yaml"
  File.open('ceps.yml','w') do |h| 
    h.write ceps.to_yaml
  end
end
