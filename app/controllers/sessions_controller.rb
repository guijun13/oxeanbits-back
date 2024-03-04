class SessionsController < ApplicationController
  protect_from_forgery with: :null_session
  
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # redirect_to movies_path
      render json: { message: 'You have successfully logged in.' }, status: 200
    else
      render json: { errors: "Invalid email or password" }, status: 422
      flash.now[:alert] = "Invalid email or password"
      # render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
