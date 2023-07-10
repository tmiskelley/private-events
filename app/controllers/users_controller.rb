class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def show
    @user = current_user
    @created_events = @user.events
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out sucessfully."
    redirect_to root_path
  end
end
