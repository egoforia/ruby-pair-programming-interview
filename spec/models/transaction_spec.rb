require 'rails_helper'

RSpec.describe Transaction, type: :model do

  let(:balance) { 100.0 }
  let(:from_account) { create(:account_with_balance, balance: balance) }
  let(:to_account) { create(:account) }

  let(:amount) { 1.0 }

  subject { described_class.new(amount: amount, from_account: from_account, to_account: to_account) }

  describe 'associations' do
    it { should belong_to(:from_account) }
    it { should belong_to(:to_account) }
  end

  describe 'account balance validations' do

    context 'enough balance' do
      let(:amount) { balance - 1 }
      
      it 'should have status = pending' do
        subject.save
        expect(subject.status).to eq("pending")
      end

      it 'should\'t change from_account balance' do
        expect{ subject.save }.to change { from_account.balance }.by(-amount)
      end

      it 'should\'t change to_account balance' do
        expect{ subject.save }.to change { to_account.balance }.by(amount)
      end
    end
    
    context 'not enough balance' do
      let(:amount) { balance + 1 }

      it 'should have status = error' do
        subject.save
        expect(subject.status).to eq("error")
      end

      it 'should\'t change from_account balance' do
        expect{ subject.save }.not_to change { from_account.balance }
      end

      it 'should\'t change to_account balance' do
        expect{ subject.save }.not_to change { to_account.balance }
      end
    end
  end
end
