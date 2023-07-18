class EventAttendeesController < ApplicationController
  before_action :authenticate_user!

  def new
    @event_attendee = EventAttendee.new
    @event_id = params[:event_id]
  end

  def create
    @event_attendee = current_user.event_attendees.build(event_attendee_params)

    if @event_attendee.save
      flash[:notice] = "Signed up for event successfully!"
      redirect_to root_path
    else
      flash.now[:alert] = "Event sign-up failed."
    end
  end

  private

  def event_attendee_params
    params.require(:event_attendee).permit(:event_id)
  end
end
