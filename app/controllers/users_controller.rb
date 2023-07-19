class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    @created_events = current_user.events
    @events = attending_events
    @upcoming_events = @events.select { |event| event.event_date >= Date.today }
    @past_events = @events.select { |event| event.event_date < Date.today }
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out sucessfully."
    redirect_to root_path
  end

  private

  def attending_events
    events = []
    my_events = EventAttendee.where(user_id: current_user.id)

    my_events.each do |event|
      events << Event.find(event.event_id)
    end

    events
  end
end
