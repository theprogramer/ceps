namespace :ceps do

  desc "Geolocalize ceps.yml file"
  task :geolocalize do
  	require 'geocoder'
    require 'retryable'
    require 'yaml'

    # raise on geocoding errors such as query limit exceeded
    Geocoder.configure(always_raise: :all)

    puts "Loading routes"
    puts "This should take some time!"
    ceps = YAML.load_file(ARGV[1]) || {}
    puts "Geolocalize new hash"
    ceps.each do |cep, value|
      query = "#{ceps[cep][:type]} #{ceps[cep][:location]}, #{ceps[cep][:neighborhood]} - #{ceps[cep][:city]} - #{ceps[cep][:state]} - cep: #{cep}" 
      begin 
        Retryable.retryable(tries: 5, sleep: lambda { |n| 2**n }) do
          geodata = Geocoder.search(query).first
          if geodata.empty?
            raise "Empty geodata"
          else
            ceps[cep][:latitude] = geodata["location"]["lat"]
            ceps[cep][:longitude] = geodata["location"]["lng"]
            puts geodata["location"]
          end 
        end
      rescue => e
        warn "Attempts exceeded for query #{query}, last error was #{e.message}"
      end
    end

    puts "Saving new ceps.yaml"
    File.open('ceps.yml','w') do |h| 
      h.write ceps.to_yaml
    end

  end

end