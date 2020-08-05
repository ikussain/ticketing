class Ticket < ActiveRecord::Base
  OPTIONS = ['New', 'Blocked', 'In progress', 'Fixed']

  validates :name, :status, presence: true
  validates :status, inclusion: { in: %w(new blocked in_progress fixed)}

  belongs_to :project, validate: true
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true
  has_many :ticket_tags, dependent: :destroy
  has_many :tags, through: :ticket_tags
  has_many :comments, dependent: :destroy
end