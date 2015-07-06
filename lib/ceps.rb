require 'ceps/version'

require 'correios'
require 'ceps/railtie' if defined?(Rails)

class Cep < Correios::Cep

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
  end

end

class Configuration
 
  attr_accessor :data_file_name

  attr_accessor :data_file_path

  attr_accessor :data_file

  def initialize
    @data_file_name = 'ceps.yaml'
    if defined?(Rails)
      @data_file_path = File.join(Rails.root, "lib", "data")
    else
      @data_file_path = File.join( 
                          File.dirname(
    	                    File.dirname(__FILE__)),
    	                    "lib", "data")
    end

    @data_file = File.join @data_file_path, @data_file_name

  end
end
