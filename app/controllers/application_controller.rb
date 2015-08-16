class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_user!
  	if user_signed_in?
   	 	return true
 	else
   		flash[:danger] = "You must be signed in to access that page."
    	redirect_to root_path
  	end
  end

   def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :acct_type
    # devise_parameter_sanitizer.for(:update_score) << :score

   end

  def update_score
    @user = current_user
    orig_score = @user.score
    @user.update_attribute(:score, orig_score += 10)
  end

end
