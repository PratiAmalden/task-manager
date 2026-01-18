module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_signed_in?
  end

  def login(user)
    reset_session
    session[:current_user_id] = user.id
    Current.user = user
  end

  def logout
    reset_session
    Current.user = nil
  end

  def authenticate_user!
    redirect_to login_path, alert: "You must be logged in!" unless user_signed_in?
  end

  private

  def current_user
    Current.user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def user_signed_in?
    current_user.present?
  end
end
