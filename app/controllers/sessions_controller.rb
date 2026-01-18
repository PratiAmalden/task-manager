class SessionsController < ApplicationController
  def create
    user = User.authenticate_by(email: params[:email], password: params[:password])
    if user
      login(user)
      render json: {
        message: "Logged in successfully",
        user: {
          id: user.id, email: user.email
        }
        }, status: :ok
    else
      render json: { errors: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    logout
    render json: { message: "Logged out successfully" }, status: :ok
  end
end
