class Person < ActiveRecord::Base
  belongs_to :user

  validates :last_name, presence: true
  validates :email, format: {with: /\A([a-zA-Z0-9._%+-]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :name, :last_name, :email, :company, :job_title, :phone, :website, length: {maximum: 255}
end
