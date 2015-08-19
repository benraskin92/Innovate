class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@challenge = current_user.challenges
	end
end
