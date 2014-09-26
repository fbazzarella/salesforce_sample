require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should belong_to(:user) }

  it { should delegate_method(:salesforce_credentials).to(:user) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:last_name) }

  it { should allow_value('email@example.com').for(:email) }
  it { should_not allow_value('invalid.email').for(:email) }
  it { should allow_value('').for(:email) }
  it { should allow_value(nil).for(:email) }

  described_class::COMMON_FIELDS.each do |field|
    it { should ensure_length_of(field).is_at_most(255) }
  end

  describe 'callbacks' do
    describe 'after_create' do
      before { described_class.any_instance.should_receive(:delay_salesforce_contact_creation) }

      it { create(:person) }
    end
  end

  describe '.delay_salesforce_contact_creation' do
    context 'when user integration is on' do
      let!(:integrated_user) { create(:user, salesforce_auth: {token: '123456'}) }
      let!(:person) { create(:person, user: integrated_user) }

      it { expect{ person.send(:delay_salesforce_contact_creation) }.to change(Sidekiq::Extensions::DelayedModel.jobs, :size).by(1) }
    end

    context 'when user integration is off' do
      let!(:person) { create(:person) }

      it { expect{ person.send(:delay_salesforce_contact_creation) }.to_not change(Sidekiq::Extensions::DelayedModel.jobs, :size) }
    end
  end

  describe '.create_salesforce_contact' do
    let!(:person) { create(:person) }

    before { Salesforce::Contact.stub_chain(:new, :create).and_return(true) }

    it { expect(person.send(:create_salesforce_contact)).to be_eql(true) }
  end

  describe 'private methods' do
    describe '.salesforce_contact_attributes' do
      let!(:person) { create(:person) }

      described_class::SFORCE_FIELDS.keys.each do |f|
        it { expect(person.send(:salesforce_contact_attributes)).to include(f.to_s) }
      end
    end
  end
end
