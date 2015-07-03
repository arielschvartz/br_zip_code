require "br_zip_code/engine"
require "br_zip_code/version"

require 'httparty'
require 'dotenv'
Dotenv.load

require "br_zip_code/config"
require "br_zip_code/service"
require "br_zip_code/service/correio_control"
require "br_zip_code/service/postmon"
require "br_zip_code/service/viacep"
require "br_zip_code/service/republica_virtual"
require "br_zip_code/service/cep_livre"

module BrZipCode

  class << self
    attr_accessor :config
    attr_accessor :services
  end

  def self.configuration
    self.config ||= BrZipCode::Config.new
  end

  def self.configure &block
    yield configuration
  end

  def self.timeout
    self.configuration.timeout || 3
  end

  def self.attempts
    self.configuration.attempts || 5
  end

  def self.timeout= value
    self.configuration.timeout = value
  end

  def self.attempts= value
    self.configuration.attempts = value
  end

  def self.strip zip_code
    zip_code.to_s.gsub(/[^0-9]/, '')
  end

  def self.formatted zip_code
    numbers = self.strip zip_code

    if numbers.length == 8
      numbers.insert(2, '.').insert(6, '-')
    else
      nil
    end
  end

  def self.services
    return @services unless @services.nil?

    @services = []

    [
      'Postmon',
      'Viacep',
      'CorreioControl',
      'RepublicaVirtual',
      'CepLivre'
    ].each do |class_name|
      @services.push Module.const_get("BrZipCode::Service::#{class_name}")
    end

    @services
  end

  def self.get zip_code
    counter = 0

    self.services.each do |s|
      counter += 1
      begin
        response = s.new(zip_code)
        if response.valid?
          return response.to_hash
        end
      rescue Net::OpenTimeout
        if counter == attempts
          raise Net::OpenTimeout
        else
          next
        end
      end
    end
  end
end
