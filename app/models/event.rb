class Event < ActiveRecord::Base
  validates :event_date, :event_name, :description, presence: true
  validates :description, length: { minimum: 10 }

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :event_attendees
  has_many :attendees, through: :event_attendees, source: :user
end
