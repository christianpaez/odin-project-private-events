class Event < ApplicationRecord
  validates :description, presence: true
  belongs_to :creator, foreign_key: 'user_id', class_name: "User"
  has_many :user_events
  has_many :attendes, through: :user_events, source: :user
end
