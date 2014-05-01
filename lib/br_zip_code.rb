require 'br_zip_code/engine'
require 'br_zip_code/version'
require 'httparty'

module BrZipCode
  def self.strip zip_code
    zip = zip_code.sub(/\./, '').sub(/\-/, '')
    # if zip.scan(/[0-9]/).length != 8 or zip.length != 8
    unless zip.to_s.match(/^\d{8}$/)
      nil
    else
      zip
    end
  end

  def self.formatted zip_code
    zip = zip_code.scan(/[0-9]/).join
    unless zip.to_s.match(/^\d{8}$/)
      nil
    else
      zip.insert(2, '.').insert(6, '-')
    end
  end

  def self.get_address zip_code
    zip = self.strip(zip_code)

    attempt = ZipCodeAttempt.new

    unless zip.nil?
      begin
        attempt.zip_code_attempt_1 zip
      rescue Exception => e
        begin
          attempt.zip_code_attempt_2 zip
        rescue Exception => e
          begin
            attempt.zip_code_attempt_3 zip
          rescue Exception => e
            { error: "CEP não encontrado" }
          end
        end
      end
    else
      { error: "CEP inválido" }
    end

  end

  class ZipCodeAttempt
    def zip_code_attempt_3 zip_code
      r = HTTParty.get("http://cep.republicavirtual.com.br/web_cep.php?cep=#{zip_code}&formato=json")
      hash = { street_type: r["tipo_logradouro"], street: r["tipo_logradouro"] + " " + r["logradouro"], state: r["uf"], city: r["cidade"], neighborhood: r["bairro"] }
      if hash[:street].blank?
        raise Exception
      else
        hash
      end
    end

    def zip_code_attempt_2 zip_code
      r = HTTParty.get("http://cep.correiocontrol.com.br/#{zip_code}.json")
      hash = { street_type: r["logradouro"].split(' ').first, street: r["logradouro"], state: r["uf"], city: r["localidade"], neighborhood: r["bairro"] }
      if hash[:street].blank?
        raise Exception
      else
        hash
      end
    end

    def zip_code_attempt_3 zip_code
      r = HTTParty.get("http://viavirtual.com.br/webservicecep.php?cep=#{zip_code}")
      hash = { street_type: r.split('|')[0].split(" ").first, street: r.split('|')[0], state: r.split('|')[8], city: r.split('|')[4], neighborhood: r.split('|')[2] }
      if hash[:street].blank?
        raise Exception
      else
        hash
      end
    end
  end

end
