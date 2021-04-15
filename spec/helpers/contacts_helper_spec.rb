require 'rails_helper'

RSpec.describe ContactsHelper, type: :helper do
  describe ContactsHelper do
    describe "Parse csv file" do
      let(:csv) { create :csv }

      it { expect(ContactsHelper.parse_csv_file(csv.id, csv, csv.user)).to be_an_instance_of(Array) }
    end

    describe "Parse csv file" do
      let(:params) { {
        header1: "name",
        header2: "date_of_birth",
        header3: "phone_number",
        header4: "address",
        header5: "credit_card_number",
        header6: "credit_card_type",
        header7: "email"
      }}

      it { expect(ContactsHelper.set_headers(params)).to contain_exactly(
        "name", "date_of_birth", "phone_number", "address", "credit_card_number", "credit_card_type",
        "email","user_id","csv_id","created_at","updated_at") }
    end

    describe "Convert file parsed to String" do
      let(:csv) { create :csv }
      let(:file_parsed) { ContactsHelper.parse_csv_file(csv.id, csv, csv.user) }
      let(:params) { {
        header1: "name",
        header2: "date_of_birth",
        header3: "phone_number",
        header4: "address",
        header5: "credit_card_number",
        header6: "credit_card_type",
        header7: "email"
      }}
      let(:headers) { ContactsHelper.set_headers(params) }

      it { expect(ContactsHelper.convert_file_parsed_to_string_content(file_parsed, headers))
        .to be_a_kind_of(String) }
    end

    describe "Get four last digits of a number" do
      let(:credit_card_number) { 4539689983136609 }

      it { expect(helper.get_four_last_digits(credit_card_number)).to eq(6609) }
    end
  end
end
