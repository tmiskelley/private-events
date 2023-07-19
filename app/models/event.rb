class Event < ActiveRecord::Base
  scope :past, -> { where('event_date < ?', Date.today) }
  scope :upcoming, -> { where('event_date >= ?', Date.today) }

  validates :event_date, :event_name, :description, presence: true
  validates :description, length: { minimum: 10 }

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :event_attendees, dependent: :destroy
  has_many :attendees, through: :event_attendees, source: :user
end
