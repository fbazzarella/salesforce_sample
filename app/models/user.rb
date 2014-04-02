class User < ActiveRecord::Base
  devise :database_authenticatable

  validates :username, presence: true, uniqueness:   true
  validates :password, presence: true, confirmation: true, length: {within: 6..24}
end
