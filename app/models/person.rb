class Person < ActiveRecord::Base
  COMMON_FIELDS = %i(name last_name email company job_title phone website)

  belongs_to :user

  validates :last_name, presence: true
  validates :email, allow_blank: true, allow_nil: true,
    format: {with: /\A([a-zA-Z0-9._%+-]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
    
  validates *COMMON_FIELDS, length: {maximum: 255}
end
