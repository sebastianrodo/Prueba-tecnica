require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  before do
    create(:user, :custom_email)
  end

  after do
    DatabaseCleaner.clean
  end

  context 'with contacts associations valid' do
    it { should have_many(:contacts) }

    it { should have_many(:csvs) }
  end

  it 'user with valid attributes' do
    should be_valid
  end

  it 'is invalid not have an email' do
    subject.email = ''
    should_not be_valid
  end

  it 'is invalid not have an password' do
    subject.password = ''
    should_not be_valid
  end

  it 'Expect fail, email already taken' do
    subject.email = 'custom_email@gmail.com'
    should_not be_valid
  end

  it 'validate password length' do
    should validate_length_of(:password)
      .is_at_least(6)
      .on(:create)
  end
end
