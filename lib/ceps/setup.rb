module Correios


  ##
  # Handles building the in memory store of CEP data
  class Setup

    attr_writer :data_file_name

    attr_writer :data_file_path

    attr_writer :data_file

    def ceps
      return @ceps if instance_variable_defined?("@ceps")
      @ceps ||= load
    end

    def data_file_name
      @data_file_name || "ceps.yaml"
    end

    def data_file_path
      @data_file_path || default_file_path
    end

    def data_file
      @data_file || File.join(data_file_path, data_file_name)
    end

    private

      def load
        YAML.load_file(data_file)
      end

      def default_file_path
        File.join(File.dirname(File.dirname(__FILE__)), "data")
      end

  end
end