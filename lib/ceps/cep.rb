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

    def initialize(cep_data)
      @data = cep_data.is_a?(Hash) ? cep_data : Setup.data[cep_data.to_s.upcase]
    end

    def valid?
      !(@data.nil? || @data.empty?)
    end

    def ==(other)
      other == data
    end

    private

    class << self

      def new(cep_data)
        if cep_data.is_a?(Hash) || Setup.data.keys.include?(cep_data)
          super
        end
      end

    end
  end

end