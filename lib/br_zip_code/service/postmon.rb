module BrZipCode
  class Service
    class Postmon < BrZipCode::Service
      def to_hash
        return nil unless self.valid? and not self.response_body.nil?

        {
          street: self.response_body['logradouro'],
          district: self.response_body['bairro'],
          city: self.response_body['cidade'],
          state: self.response_body['estado']
        }
      end

      def valid?
        super and self.response.code == 200 and self.response_body != ''
      end

      def final_url
        "#{base_url}#{self.zip_code}"
      end

      def base_url
        "http://api.postmon.com.br/v1/cep/"
      end
    end
  end
end
