class Person < ActiveRecord::Base
  COMMON_FIELDS = %i(name last_name email company job_title phone website)
  
  belongs_to :user

  delegate :salesforce_credentials, to: :user

  validates :user_id, :last_name, presence: true
  validates :email, allow_blank: true, allow_nil: true,
    format: {with: /\A([a-zA-Z0-9._%+-]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
    
  validates *COMMON_FIELDS, length: {maximum: 255}

  SFORCE_FIELDS = {
    FirstName: :name,
    LastName: :last_name,
    Email: :email,
    Company__c: :company,
    JobTitle__c: :job_title,
    Phone: :phone,
    Website__c: :website }

  SFORCE_FIELDS.each_pair {|k, v| alias_attribute(k, v)}

  private

  def salesforce_contact_attributes
    SFORCE_FIELDS.keys.inject({}) {|h, a| h.merge({a.to_s => send(a)})}
  end
end
