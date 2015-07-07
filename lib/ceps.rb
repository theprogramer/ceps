require 'ceps/version'

require 'correios'
require 'ceps/railtie' if defined?(Rails)

class Cep < Correios::Cep

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Correios::Setup.new
    yield(configuration)
  end

end
