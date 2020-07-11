class Event < ApplicationRecord

    def past?
      date.past?
    end

    scope :upcoming_events, -> {where('date > ?', Date.today)}
    scope :previous_events, -> {where('date < ?', Date.today)}

    validates :description, presence: true
    validates :location, presence: true
    validates :date, presence: true
    belongs_to :creator, foreign_key: :user_id, class_name: "User"
    has_many :user_events
    has_many :attendes, through: :user_events, source: :user
  end
  