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

    attr_accessor :configuration

    def self.configure
      @configuration ||= Correios::Setup.new
    end

    def initialize(cep)
      @data = cep.is_a?(Hash) ? cep : Cep.configure.ceps[cep]
    end

    def valid?
      !(@data.nil? || @data.empty?)
    end

    def ==(other)
      other == data
    end

    private
      def new(cep)
        if cep.is_a?(Hash) || Cep.configure.ceps.keys.include?(cep)
          super
        end
      end
  end

end