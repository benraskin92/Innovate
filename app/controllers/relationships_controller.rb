class RelationshipsController < ApplicationController

	def create
		@challenge = Challenge.find(params[:relationship][:followed_id])
		current_user.follow_challenge!(@challenge)
		redirect_to(:back)
		flash[:success] = "You are now following this challenge."
	end

	def destroy
		@challenge = Relationship.find(params[:id]).followed_id
		current_user.challenge_unfollow!(@challenge)
		redirect_to(:back)
		flash[:danger] = "You are no longer following this challenge."
	end

end
