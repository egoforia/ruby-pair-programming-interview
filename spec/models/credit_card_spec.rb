require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:last_digits) }
    it { should validate_length_of(:last_digits).is_equal_to(4) }
    it { should validate_presence_of(:holder_name) }
    it { should validate_presence_of(:expiration_date) }
    it { should validate_presence_of(:number).on(:create) }
    it { should validate_presence_of(:expiration_month).on(:create) }
    it { should validate_presence_of(:expiration_year).on(:create) }

    context 'invalid expiration date' do
      let(:expiration_month) { 1.year.ago.month }
      let(:expiration_year) { 1.year.ago.year }

      subject { build(:credit_card, expiration_month: expiration_month, expiration_year: expiration_year) }
      
      it "should't be in the past" do
        expect(subject).to_not be_valid
        expect(subject.errors.messages[:expiration_date]).to include("can't be in the past")
      end
    end
  end

  describe 'set last digits on create' do
    subject { build(:credit_card, last_digits: nil, number: '1234-1234-5678-5678') }

    it 'should set last digits' do
      subject.save
      expect(subject.last_digits).to eq('5678')
    end
  end

  describe 'set expiration_date on create' do
    subject { build(:credit_card, expiration_month: 1, expiration_year: 2.years.from_now.year) }

    it 'should set expiration_date' do
      subject.save
      expect(subject.expiration_date).to eq(Date.new(2.years.from_now.year, 1, 1))
    end
  end
end
