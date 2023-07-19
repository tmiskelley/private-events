class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :username, presence: true

  has_many :events
  has_many :event_attendees, dependent: :destroy
  has_many :attended_events, through: :event_attendees, source: :event
end
