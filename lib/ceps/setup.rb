module Correios


  ##
  # Handles building the in memory store of CEP data
  class Setup

    attr_writer :data_file_name

    attr_writer :data_file_path

    attr_writer :data_file

    attr_writer :main_data_file_name

    attr_writer :main_data_file_path

    attr_writer :main_data_file

    attr_accessor :cep

    def ceps
      return @ceps if instance_variable_defined?("@ceps")
      @ceps ||= load
    end

    def cep_key
      cep[0,5]
    end

    def cep
      @cep || ""
    end

    def cep=(key="")
      @cep = key
    end

    def main_data_file_name
      @main_data_file_name || "ceps.yaml"
    end

    def main_data_file_path
      @main_data_file_path || "#{default_file_path}/"
    end

    def main_data_file
      @main_data_file || File.join(main_data_file_path, main_data_file_name)
    end

    def data_file_name
      @data_file_name || "#{cep_key}.yaml"
    end

    def data_file_path
      @data_file_path || "#{default_file_path}/#{cep_key.split(//).join('/')}/"
    end

    def data_file
      @data_file || File.join(data_file_path, data_file_name)
    end

    private

      def load
        YAML.load_file(data_file)
      end

      def default_file_path
        File.join(File.dirname(File.dirname(__FILE__)), "data", "ceps")
      end

      def initialize(cep = nil)
        @cep = cep
      end

  end
end
