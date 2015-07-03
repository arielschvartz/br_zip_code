module BrZipCode
  class Service
    attr_accessor :zip_code, :response, :response_body

    def initialize zip_code, no_timeout = false
      @zip_code = BrZipCode.strip(zip_code)

      return unless self.basic_valid?

      if no_timeout
        @response = HTTParty.get(final_url)
      else
        @response = HTTParty.get(final_url, timeout: BrZipCode.timeout)
      end

      @response_body = @response.response.body

      if self.valid?
        @response_body = JSON.parse(@response_body)
      end
    end

    def basic_valid?
      @zip_code.length == 8
    end

    def valid?
      not self.response.nil? and not self.response_body.nil? and not zip_code.nil?
    end
  end
end
