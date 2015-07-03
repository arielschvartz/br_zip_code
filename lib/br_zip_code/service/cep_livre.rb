require 'nokogiri'

module BrZipCode
  class Service
    class CepLivre < BrZipCode::Service

      def initialize zip_code, no_timeout = false
        raise 'Environment Variable CEP_LIVRE_TOKEN not set.' if ENV['CEP_LIVRE_TOKEN'].nil?

        @zip_code = zip_code.to_s.gsub(/[^0-9]/, '')

        return unless self.basic_valid?

        @zip_code = @zip_code[0..4] + '-' + @zip_code[5..-1]

        if no_timeout
          @response = HTTParty.get(final_url)
        else
          @response = HTTParty.get(final_url, timeout: BrZipCode.timeout)
        end

        @response_body = @response.response.body

        if self.valid?
          xml = Nokogiri.XML(@response_body)
          children = xml.xpath("//cep").children

          names = children.map { |x| x.name }
          values = children.map { |x| x.children }.flatten.map { |x| x.text }

          h = Hash[names.zip values]
          @response_body = {
            'ceplivre' => {
              'cep' => h
            }
          }
        end
      end

      def to_hash
        return nil unless self.valid?

        cep_body = response_body['ceplivre']['cep']

        {
          street: [cep_body['tp_logradouro'],cep_body['logradouro']].join(' '),
          district: cep_body['bairro'],
          city: cep_body['cidade'],
          state: cep_body['uf_sigla']
        }
      end

      def valid?
        super and self.response.code == 200 and not self.response_body == '' and not self.response_body['ceplivre'].nil?
      end

      def final_url
        "#{base_url}#{self.zip_code}/xml"
      end

      def base_url
        "http://ceplivre.com.br/consultar/cep/#{ENV['CEP_LIVRE_TOKEN']}/"
      end
    end
  end
end
