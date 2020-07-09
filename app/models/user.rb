class User < ApplicationRecord
    validates :name, presence: true
    has_many :events 
    has_many :user_events
    has_many :attended_events, through: :user_events, source: :event
end
