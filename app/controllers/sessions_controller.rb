class SessionsController < ApplicationController
  def new
    @session = UserSession.new
  end

  def create
    @session = UserSession.new params[:user_session]
    @user = login(@session.username, @session.password, @session.remember_me)
    if @user
      redirect_back_or_to root_url, :notice => 'Successfully signed in!'
    else
      flash.now.alert = "Incorrect password or username!"
      render :new
    end
  end

  def destroy
    logout
    redirect_back_or_to root_url, :notice => 'Successfully signed out!'
  end
end
