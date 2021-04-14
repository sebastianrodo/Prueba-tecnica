require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject { create :contact }

  before do
    create(:contact, :custom_email)
  end

  after do
    DatabaseCleaner.clean
  end

  context 'with associations' do
    it { should belong_to(:csv) }
    it { should belong_to(:user) }
  end

  it 'contact with valid attributes' do
    should be_valid
  end

  it 'is invalid not have a name' do
    subject.name = ''
    should_not be_valid
  end

  it 'is invalid only special characters except minus (-)' do
    subject.name = 'fake_name'
    should_not be_valid
    subject.name = '12345'
    should_not be_valid
  end

  it 'is invalid not have a date of birth' do
    subject.date_of_birth = ''
    should_not be_valid
  end

  it 'is invalid, should have a date of birth format' do
    subject.date_of_birth = '121231312'
    should_not be_valid
  end

  it 'is invalid not have a phone number' do
    subject.phone_number = ''
    should_not be_valid
  end

  it 'is invalid not have a correct format (+00) 000-000-00-00 and (+00) 000 000 00 00' do
    subject.phone_number = '+(00) 123-342 03-21'
    should_not be_valid
  end

  it 'is invalid not have an address' do
    subject.address = ''
    should_not be_valid
  end

  it 'is invalid not have a credit card number' do
    subject.credit_card_number = ''
    should_not be_valid
  end

  it 'is invalid not have a valid credit card number' do
    subject.credit_card_number = '71721gshxx22'
    should_not be_valid
  end

  it 'is invalid not have a valid credit card type' do
    subject.credit_card_type = ''
    should_not be_valid
  end

  it 'is invalid not have an email' do
    subject.email = ''
    should_not be_valid
  end
end
