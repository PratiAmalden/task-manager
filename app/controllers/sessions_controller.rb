class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])
    if user
      login user
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:notice] = "Logged out successfully"
    redirect_to root_path
  end
end
