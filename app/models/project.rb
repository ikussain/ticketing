class Project < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }

  has_many :tickets, dependent: :destroy
end