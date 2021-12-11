class Api::Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_sign_up_params, only: [:create]

  def create
    super
  end

  private

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address, :phone,
                                                       :admin, :subscription_ending, :package_id])
  end

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed
  end

  def register_success
    render json: user_response(current_user)
  end

  def register_failed
    render json: { message: "Something went wrong." }
  end
end