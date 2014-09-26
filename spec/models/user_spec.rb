require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:people).dependent(:restrict_with_error) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }

  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }
  it { should ensure_length_of(:password).is_at_least(6).is_at_most(24) }

  describe '.integrated_with_salesforce?' do
    let!(:integrated_user) { create(:user, salesforce_auth: {token: '123456'}) }
    let!(:not_integrated_user) { create(:user) }

    it { expect(integrated_user.integrated_with_salesforce?).to be_eql(true) }
    it { expect(not_integrated_user.integrated_with_salesforce?).to be_eql(false) }
  end

  describe '.salesforce_credentials' do
    let!(:auth_hash) { {token: '123456', expires: false, instance_url: 'lol.com'} }
    let!(:user) { create(:user, salesforce_auth: auth_hash) }

    it { expect(user.salesforce_credentials).to be_eql(['123456', 'lol.com']) }
  end
end
