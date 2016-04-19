namespace :ceps do

  desc 'Import MDB file'
  task :import do

    require 'mdb'
    require 'yaml'
    require 'ceps'
    require_relative '../ceps/mdb'
    require 'ruby-progressbar'

    puts "\n\nLoad from #{ARGV[1]}"
    puts "\n\n\n -----------------"
    puts "Importing to #{Correios::Cep.configure.main_data_file}"
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
    File.open(Correios::Cep.configure.main_data_file,'w') do |h| 
      h.write ceps.to_yaml
    end
  end

  desc "ceps.yml file"
  task :split do
    require 'geocoder'
    require 'retryable'
    require 'yaml'
    require 'ceps'
    require 'fileutils'

    puts "Loading routes"
    puts "This should take some time!"
    main_hash = YAML.load_file(ARGV[1] || Cep.configure.data_file) || {}
    ceps = {}
    puts "Generating new hashes"
    main_hash.each do |cep, value|
      query = "#{main_hash[cep][:type]} #{main_hash[cep][:location]}, #{main_hash[cep][:neighborhood]} - #{main_hash[cep][:city]} - #{main_hash[cep][:state]} - cep: #{cep}" 
      ceps[cep.to_s[0,5].to_i] ||= {}
      ceps[cep.to_s[0,5].to_i][cep] = value
    end

    ceps.each do |cep_key, value|
      file_name = "#{cep_key}.yaml"
      root_path = ARGV[2] || Cep.configure.data_file_path
      path = "#{root_path}/ceps/#{cep_key.to_s.split(//).join('/')}/"
      file = "#{path}#{file_name}"
      puts "Saving new #{cep_key}.yaml to #{path}"
      FileUtils.mkdir_p path
      File.open(file,"w") { |h| h.write value.to_yaml; }
    end

  end

end
