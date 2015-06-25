module Correios

  ##
  # Handles building the in memory store of CEP data
  class Setup
    def ceps
      @ceps ||= load(['data', 'ceps.yaml'])
    end

    def data
      return @data if instance_variable_defined?('@data')
      @data ||= load(['data', 'data.yaml'])
    end

    private

    def datafile_path(file_array)
      File.join([File.dirname(__FILE__), '..'] + file_array)
    end

    def load(file_array)
      YAML.load_file(datafile_path(file_array))
    end
  end
end