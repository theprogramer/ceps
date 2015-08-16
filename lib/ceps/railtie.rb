require_relative 'cep.rb'
require 'rails'

module Ceps
  class Railtie < Rails::Railtie
    
    railtie_name :ceps

    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end

  end
end