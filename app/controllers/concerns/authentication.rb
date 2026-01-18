module Authentication
  extend ActiveSupport::Concern


  def login(user)
    reset_session
    session[:current_user_id] = user.id
    Current.user = user
  end

  def logout
    reset_session
  end

  def authenticate_user!
    return if user_signed_in?
    render json: {
      message: "Unauthorized"
      }, status: :unauthorized
  end

  private

  def current_user
    Current.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def user_signed_in?
    current_user.present?
  end
end
