class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
    @events = Event.all
    @upcoming_events = Event.upcoming
    @past_events = Event.past
  end

  def show
    @event = Event.find(params[:id])
    @attendees = find_attendees
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = "Event created successfully"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:event_date, :event_name, :description)
  end

  def find_attendees
    attendees = []
    event_attendees = EventAttendee.where(event_id: @event.id)

    event_attendees.each do |record|
      attendees << User.find(record.user_id).username
    end

    attendees
  end
end
