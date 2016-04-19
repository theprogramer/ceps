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

    attr_writer :cep

    attr_accessor :configuration

    def self.configure
      @configuration ||= Correios::Setup.new(@cep)
    end

    def initialize(cep = nil)
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
        @cep = cep
        if cep.is_a?(Hash) || @configuration.ceps.keys.include?(cep)
          super
        end
      end


  end

end