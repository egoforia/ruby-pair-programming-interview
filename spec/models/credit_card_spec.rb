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

    context 'invalid expiration date' do
      let(:expiration_date) { 1.year.ago }

      subject { build(:credit_card, expiration_date: expiration_date) }
      
      it "should't be in the past" do
        expect(subject).to_not be_valid
        expect(subject.errors.messages[:expiration_date]).to include("can't be in the past")
      end
    end
  end
end
