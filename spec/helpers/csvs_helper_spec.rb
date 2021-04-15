require 'rails_helper'

RSpec.describe CsvsHelper, type: :helper do
  describe CsvsHelper do
    describe "get credit card brand" do
      let(:credit_card_number) { 5555555555554444 }

      it { expect(helper.get_credit_card_brand(credit_card_number)).to eq("MasterCard") }
    end

    describe "get csv file name" do
      let(:csv) { create :csv }
      it { expect(helper.file_name(csv)).to eq("contacts.csv") }
    end

    describe "Parse csv file" do
      let(:csv) { create :csv }
      it { expect(CsvsHelper.parse_csv_file(csv)).to be_an_instance_of(Array) }
    end
  end
end
