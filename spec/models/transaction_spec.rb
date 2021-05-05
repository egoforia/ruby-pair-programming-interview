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

  describe 'enums' do
    it do
      should define_enum_for(:status).
        with_values([:pending, :success, :error])
    end
    it do
      should define_enum_for(:transaction_type).
        with_values([:transfer, :credit_card])
    end
  end

  describe 'account balance validations' do

    context 'enough balance' do
      it 'should have status = success' do
        subject.save
        expect(subject.status).to eq("success")
      end

      it 'should change from_account balance' do
        expect{ subject.save }.to change { from_account.balance }.by(-amount)
      end

      it 'should change to_account balance' do
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
