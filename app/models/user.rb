class User < ActiveRecord::Base
  has_many :people, dependent: :restrict_with_error

  devise :database_authenticatable

  serialize :salesforce_auth, UserSalesforceAuth

  validates :username, presence: true, uniqueness:   true
  validates :password, presence: true, confirmation: true, length: {within: 6..24}

  def integrated_with_salesforce?
    salesforce_auth.token.present?
  end

  def salesforce_credentials
    salesforce_auth.to_hash.except(:expires).values
  end
end
