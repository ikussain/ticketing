class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, on: :create, length: { minimum: 5 }

  has_many :tickets
end