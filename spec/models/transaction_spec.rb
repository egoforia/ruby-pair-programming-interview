require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to(:from_account) }
    it { should belong_to(:to_account) }
  end
end
