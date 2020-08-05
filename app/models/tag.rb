class Tag < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }

  has_many :ticket_tags, dependent: :destroy
  has_many :tickets, through: :ticket_tags
end