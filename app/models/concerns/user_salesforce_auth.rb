class UserSalesforceAuth
  include Virtus.model

  attribute :token,        String
  attribute :expires,      Boolean
  attribute :instance_url, String

  def self.dump(salesforce_auth)
    salesforce_auth.to_hash
  end

  def self.load(salesforce_auth)
    new(salesforce_auth)
  end
end
