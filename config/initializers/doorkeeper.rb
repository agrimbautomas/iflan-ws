# frozen_string_literal: true

Doorkeeper.configure do
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    raise "Please configure doorkeeper resource_owner_authenticator block located in #{__FILE__}"
    # Put your resource owner authentication logic here.
    # Example implementation:
    #   User.find_by(id: session[:user_id]) || redirect_to(new_user_session_url)
	end

  resource_owner_from_credentials do |routes|
    begin
      LogInUser.with email: params[:email], password: params[:password]
    rescue IflanError => e
      render_failed_response e.error, e.error_message, e.status_code
    end
  end

  grant_flows %w(password)

end

