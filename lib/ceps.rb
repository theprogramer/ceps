require 'ceps/version'

require 'correios'
require 'ceps/railtie' if defined?(Rails)

class Cep < Correios::Cep

end
