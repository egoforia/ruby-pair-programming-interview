require 'rails_helper'

RSpec.describe Account, type: :model do

  subject { build(:account) }

  describe 'associations' do
    it { should belong_to(:user)  }
    it { should have_many(:transactions).with_foreign_key('from_account_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
  end

  describe 'default values' do
    context 'balance' do
      it 'should be 0.0' do
        subject.save
        expect(subject.balance).to eq(0.0)
      end
    end
  end
end
