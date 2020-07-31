class Ticket < ActiveRecord::Base
  validates :name, :body, :status, presence: true
  validates :status, inclusion: { in: %w(new blocked in_progress fixed)}

  belongs_to :project
end