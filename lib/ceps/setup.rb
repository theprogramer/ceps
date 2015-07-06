module Correios

  ##
  # Handles building the in memory store of CEP data
  class Setup

    attr_accessor :data_file_name

    attr_accessor :data_file_path

    attr_accessor :data_file

    def ceps
      return @ceps if instance_variable_defined?('@ceps')
      @ceps ||= load
    end

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

    private

      def load
        YAML.load_file(@data_file)
      end

  end
end