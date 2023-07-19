class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    @user = current_user
    @created_events = @user.events
    @events = attending_events
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out sucessfully."
    redirect_to root_path
  end

  private

  def attending_events
    events = []
    my_events = EventAttendee.where(user_id: @user.id)

    my_events.each do |event|
      events << Event.find(event.event_id)
    end

    events
  end
end
