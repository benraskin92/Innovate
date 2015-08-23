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
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :bio
    devise_parameter_sanitizer.for(:sign_up) << :profile_pic
   end

  def update_score
    @user = current_user
    orig_score = @user.score
    @user.update_attribute(:score, orig_score += 10)
  end

  def challenge_owner
    @challenge = Challenge.find(params[:id])
    if current_user.id == @challenge.user_id
      @challenge = current_user.challenges.find(params[:id])
    else
      redirect_to root_path
      flash[:notice] = 'You do not have permissions to view this challenge'
    end
  end

end
