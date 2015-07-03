require 'spec_helper'

describe BrZipCode do
  it 'has a version number' do
    expect(BrZipCode::VERSION).not_to be nil
  end

  # RESPOND TO
  [:timeout, :attempts, :timeout=, :attempts=, :configuration, :services, :strip, :formatted].each do |attr|
    it "should respond to #{attr}" do
      respond_to attr
    end
  end

  # DEFAULT VALUES
  it 'has a default 3 timeout' do
    expect(BrZipCode.timeout).to eq(3)
  end

  it 'has a default total timeout' do
    expect(BrZipCode.attempts).to eq(5)
  end

  it 'has a list of services' do
    expect(BrZipCode.services).to eq([
      BrZipCode::Service::Postmon,
      BrZipCode::Service::Viacep,
      BrZipCode::Service::RepublicaVirtual,
      BrZipCode::Service::CepLivre,
      BrZipCode::Service::CorreioControl
    ])
  end

  # FORMATTED METHOD
  describe 'the formatted method' do
    ['22441090', '22.441-090', '22.441090', '22441-090'].each do |zip_code|
      it "with the zip code #{zip_code} should be formatted" do
        expect(BrZipCode.formatted(zip_code)).to eq('22.441-090')
      end
    end
  end

  # CONFIGURE NEW VALUES FOR CONFIG
  describe 'when new values for config vars are set' do
    before do
      BrZipCode.configure do |config|
        config.timeout = 10
        config.attempts = 20
      end
    end

    it "should really set the variables" do
      expect(BrZipCode.timeout).to eq(10)
      expect(BrZipCode.attempts).to eq(20)
    end
  end
end
