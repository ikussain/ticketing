class Comment < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :creator, class_name: 'User'

  validates :body, presence: true
end