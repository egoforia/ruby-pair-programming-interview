require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:accounts) }
    it { should have_many(:credit_cards) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }  
  end

  describe 'balance_total' do
    let(:user) { create(:user) }

    before(:each) do
      create(:account_with_balance, balance: 55.55, user: user)
      create(:account_with_balance, balance: 99.99, user: user)

      user.reload
    end

    it 'should return sum of accounts balance' do
      expect(user.balance_total).to eq(55.55 + 99.99)
    end
  end
end
