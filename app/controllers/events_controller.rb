class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
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

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      flash[:notice] = "Event updated successfully!"
      redirect_to @event
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    flash[:notice] = "Event deleted successfully"
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:event_date, :event_name, :description)
  end

  def authorize_user
    event = Event.find(params[:id])

    unless current_user.id == event.user_id
      flash[:alert] = "You do not have permission to modifiy this event"
      redirect_to root_path
    end
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
