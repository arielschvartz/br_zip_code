RSpec.shared_examples 'basic_service' do
  it 'should exist' do
    expect { described_class }.not_to raise_error
  end

  # RESPOND TO
  [:zip_code, :response, :initialize, :valid?, :final_url, :base_url, :to_hash].each do |attr|
    it "respond to #{attr}" do
      respond_to attr
    end
  end

  # TO HASH SHOULD GENERATE THE CORRECT HASH
  describe "when to_hash is called" do
    before do
      @service = described_class.new('22441090')
    end

    it "should generate the correct hash keys" do
      expect(@service.to_hash.keys).to eq([:street, :district, :city, :state])
    end
  end

  # VALID CEP
  ['22441090', '22451090', '71680369', '68901315'].each do |zip_code|
    it "should be valid with the #{zip_code} zip code" do
      expect(described_class.new(zip_code).valid?).to eq(true)
    end
  end

  # INVALID CEP
  ['000', '00000000', '99999999'].each do |zip_code|
    it "should not be valid with the #{zip_code} zip code" do
      expect(described_class.new(zip_code).valid?).to eq(false)
    end
  end
end
