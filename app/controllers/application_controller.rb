class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def verify_admin
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "controllers.application.flash.danger.invalid_user"
      redirect_to root_url
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit :name, :email, :chatwork_id, :password,
        :password_confirmation
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :name, :email, :chatwork_id, :password,
        :password_confirmation, :current_password
    end
  end
end
