module Correios

  class Cep

    Setup = Correios::Setup.new

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

    def initialize(cep)
      @data = cep.is_a?(Hash) ? cep : Setup.data[cep]
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
        if cep.is_a?(Hash) || Setup.data.keys.include?(cep)
          super
        end
      end

    end
  end

end