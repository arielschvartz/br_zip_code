module BrZipCode
  class Service
    class RepublicaVirtual < BrZipCode::Service
      def to_hash
        return nil unless self.valid? and not self.response_body.nil?

        {
          street: [self.response_body['tipo_logradouro'],self.response_body['logradouro']].join(' '),
          district: self.response_body['bairro'],
          city: self.response_body['cidade'],
          state: self.response_body['uf']
        }
      end

      def valid?
        super and self.response.code == 200 and not self.response_body.include? '"resultado":"0"'
      end

      def final_url
        "#{base_url}#{self.zip_code}&formato=json"
      end

      def base_url
        "http://cep.republicavirtual.com.br/web_cep.php?cep="
      end
    end
  end
end
