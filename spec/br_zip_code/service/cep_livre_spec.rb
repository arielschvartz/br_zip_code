require 'spec_helper'

describe BrZipCode::Service::CepLivre do
  include_examples 'basic_service'

  describe "when to_hash is called" do
    before do
      @service = BrZipCode::Service::CepLivre.new('22451090')
    end

    it "should generate the correct hash values" do
      expect(@service.to_hash.values).to eq([
        "Rua Duque Estrada",
        "Gávea",
        "Rio de Janeiro",
        "RJ"
      ])
    end
  end
end
