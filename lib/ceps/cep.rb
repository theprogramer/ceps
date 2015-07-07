module Correios

  class Cep

    AttrReaders = [
      :location,
      :type,
      :neighborhood,
      :city,
      :state
    ]

    AttrReaders.each do |meth|
      define_method meth do
        @data[meth.to_s]
      end
    end

    attr_reader :data

    class << self
      attr_accessor :configuration
    end


    def self.configure
      self.configuration ||= Correios::Setup.new
    end

    def initialize(cep)
      @data = cep.is_a?(Hash) ? cep : self.configuration.ceps[cep]
    end

    def valid?
      !(@data.nil? || @data.empty?)
    end

    def ==(other)
      other == data
    end

    private

    class << self

      def new(cep)
        if cep.is_a?(Hash) || Setup.ceps.keys.include?(cep)
          super
        end
      end

    end
  end

end