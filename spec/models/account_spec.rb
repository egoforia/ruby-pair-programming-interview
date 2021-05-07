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

  describe 'withdraw' do
    subject { create(:account, balance: 100.0) }
    let(:amount) { 33.33 }

    it 'should remove amount from balance' do
      expect{ subject.withdraw(amount) }.to change(subject, :balance).by(-amount)
    end
  end

  describe 'deposit' do
    subject { create(:account, balance: 100.0) }
    let(:amount) { 33.33 }
    
    it 'should remove amount from balance' do
      expect{ subject.deposit(amount) }.to change(subject, :balance).by(amount)
    end
  end

  describe 'transfer' do
    subject { create(:account, balance: 100.0) }
    let(:to_account) { create(:account) }

    context 'has enough balance' do
      let(:amount) { 33.33 }

      it 'should transfer amount from account to another acount' do
        subject.transfer(amount, to_account)

        expect{ subject.transfer(amount, to_account) }.to change(subject, :balance).by(-amount)
        expect{ subject.transfer(amount, to_account) }.to change(to_account, :balance).by(amount)
      end

      # it 'should transfer amount from account to another acount' do
      #   subject.transfer(amount, to_account)

      #   expect{ subject.transfer(amount, to_account) }.to change(to_account, :balance).by(amount)
      # end
    end

    context "don't have enough balance" do
      let(:amount) { 333.33 }
      
      it 'should raise Not enough balance error' do
        expect{ subject.transfer(amount, to_account) }.to raise_error('Not enough balance')
      end
    end
  end
end
