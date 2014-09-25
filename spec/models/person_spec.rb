require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should belong_to(:user) }

  it { should validate_presence_of(:last_name) }

  it { should allow_value('email@example.com').for(:email) }
  it { should_not allow_value('invalid.email').for(:email) }
  it { should allow_value('').for(:email) }
  it { should allow_value(nil).for(:email) }

  Person::COMMON_FIELDS.each do |field|
    it { should ensure_length_of(field).is_at_most(255) }
  end
end
