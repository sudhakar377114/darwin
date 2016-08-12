class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  before_action :authenticate_user_token!

  def authenticate_user_token!
    unauthorized_access if current_user.blank?
  end

  def current_user
    @current_user ||= User.from_api_key(request.env["HTTP_X_API_KEY"], true)
  end

  private

  def unauthorized_access
    render json: { unauthorized: true }
  end

end
