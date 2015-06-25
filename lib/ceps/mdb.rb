module Correios
  
  class Mdb

    def self.decript(cep = "")
      decripted = ""
      unless cep.empty?
      	cep.scan(/../).each do |k|
      	  case k
            when "X8", "CN", "8X", "NC"
          	  decripted << "1"
            when "Z0", "EP", "0Z", "PE"
          	  decripted << "2"
            when "1B", "GR", "B1", "RG"
          	  decripted << "3"
            when "3D", "ID", "D3", "DI"
          	  decripted << "4"
            when "4C", "JS", "C4", "SJ"
          	  decripted << "5"
            when "2A", "HQ", "A2", "QH"
          	  decripted << "6"
            when "09", "FO", "90", "OF"
          	  decripted << "7"
            when "Y7", "DM", "7Y", "MD"
          	  decripted << "8"
            when "5V", "BK", "V5", "KB"
              decripted << "9"
            when "UG", "AL", "GU", "LA"
          	  decripted << "0"
          end
        end
      end
      decripted
    end

  end

end