module BrZipCode
  class Service
    class Viacep < BrZipCode::Service
      def to_hash
        return nil unless self.valid?

        {
          street: self.response_body['logradouro'],
          district: self.response_body['bairro'],
          city: self.response_body['localidade'],
          state: self.response_body['uf']
        }
      end

      def valid?
        super and self.response.code == 200 and not self.response_body.include? 'erro'
      end

      def final_url
        "#{base_url}#{self.zip_code}/json/"
      end

      def base_url
        "http://viacep.com.br/ws/"
      end
    end
  end
end

