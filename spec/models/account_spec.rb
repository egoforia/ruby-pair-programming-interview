require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'associations' do
    it { should belong_to(:user)  }
    it { should have_many(:transactions).with_foreign_key('from_account_id') }
  end
end
