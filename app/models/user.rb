class User < ActiveRecord::Base
  has_many :people, dependent: :restrict_with_error

  devise :database_authenticatable

  store_accessor :salesforce_auth

  validates :username, presence: true, uniqueness:   true
  validates :password, presence: true, confirmation: true, length: {within: 6..24}
end
