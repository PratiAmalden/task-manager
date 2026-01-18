class RegistrationsController < ApplicationController
  def create
    user = User.new(registration_params)
    if user.save
      login(user)
      render json:
      {
        message: "Account created successfully!",
        user: { id: user.id, email: user.email } },
        status: :created
    else
      render json: { errors: user.errors.full_message }, status: :unprocessable_entity
    end
  end

  private
  def registration_params
    params.expect(user: [ :email, :password, :password_confirmation ])
  end
end
