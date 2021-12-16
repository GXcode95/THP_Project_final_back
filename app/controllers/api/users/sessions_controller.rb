class Api::Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    log_in_success && return if current_user

    log_in_failure
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: "You are logged out." }, status: :ok
  end

  def log_out_failure
    render json: { error: "Hmm nothing happened."}, status: :ok
  end

  def log_in_success
    render json: user_response(current_user), status: :ok
  end

  def log_in_failure
    render json: { error: 'Failed to log in' }, status: :ok
  end
end