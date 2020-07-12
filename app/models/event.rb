class Event < ApplicationRecord

    def past?
      date.past?
    end

    def attendant?(user)
      puts attendes.where(id: user)
      if attendes.where(id: user).count > 0
        true
      else
        false
      end
    end

    scope :upcoming_events, -> {where('date > ?', Date.today).order(date: :desc)}
    scope :previous_events, -> {where('date < ?', Date.today).order(date: :desc)}

    validates :description, presence: true
    validates :location, presence: true
    validates :date, presence: true
    belongs_to :creator, foreign_key: :user_id, class_name: "User"
    has_many :user_events
    has_many :attendes, through: :user_events, source: :user
  end
  