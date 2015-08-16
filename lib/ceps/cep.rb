module Correios

  class Cep

    AttrReaders = {
      l: :location,
      t: :type,
      n: :neighborhood,
      c: :city,
      s: :state
    }

    AttrReaders.each do |short, long|
      define_method long do
        @data[short.to_s]
      end
    end

    attr_reader :data

    attr_accessor :configuration

    def self.configure
      @configuration ||= Correios::Setup.new
    end

    def initialize(cep)
      @data = cep.is_a?(Hash) ? cep : self.class.configure.ceps[cep]
    end

    def valid?
      !(@data.nil? || @data.empty?)
    end

    def ==(other)
      other == data
    end

    private
      def new(cep)
        if cep.is_a?(Hash) || @configuration.ceps.keys.include?(cep)
          super
        end
      end
  end

end