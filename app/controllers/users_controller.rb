class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
		@user = User.find(params[:id])
		@challenge = @user.challenges
		@solution = @user.solutions
    @working_challenges = Challenge.find_by_sql("SELECT c.* FROM challenges c, solutions s WHERE s.challenge_id = c.id AND s.user_id = #{current_user.id} ")
	end

	def edit
    	@user = User.find(params[:id])
    	if current_user.id == @user.id
    		@user = User.find(params[:id])
    	else
    		redirect_to root_path
    		flash[:danger] = "You don't have permissions to view this page."
    	end
  end

  def update
   	@user = User.find(params[:id])
    if @user.update_without_password(user_params)
    	sign_in(@user, :bypass => true)
      flash[:success] = 'Profile Updated!'
      redirect_to user_path
    else
      	render 'edit'
    end
  end

    private

#Defines user parameters
  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :profile_pic)
  end

end