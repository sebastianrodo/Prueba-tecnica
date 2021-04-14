require 'rails_helper'

RSpec.describe Csv, type: :model do
  subject { build :csv }

  context 'with associations' do
    it { should have_many(:contacts) }

    it { should belong_to(:user) }
  end

  context 'expect have one attached' do
    it { should have_one_attached(:file) }
  end

  it 'csv with valid attributes' do
    should be_valid
  end
end
