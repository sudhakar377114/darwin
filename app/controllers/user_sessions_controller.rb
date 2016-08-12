class UserSessionsController < Devise::SessionsController

  skip_before_action :authenticate_user_token!, :verify_signed_out_user

  def create
    resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    render json: { api_key: resource.generate_api_key }, status: :created
  end

  def destroy
    if User.from_api_key(request.env['HTTP_X_API_KEY'])
      Rails.cache.delete User.cached_api_key(request.env['HTTP_X_API_KEY'])
      head :ok
    else
      head :unauthorized
    end
  end

end