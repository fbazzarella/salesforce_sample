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

  describe 'private methods' do
    describe '.salesforce_contact_attributes' do
      let!(:person) { create(:person) }

      described_class::SFORCE_FIELDS.keys.each do |f|
        it { expect(person.send(:salesforce_contact_attributes)).to include(f.to_s) }
      end
    end
  end
end
