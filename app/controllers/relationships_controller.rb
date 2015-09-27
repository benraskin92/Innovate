class RelationshipsController < ApplicationController

	def create
		@challenge = Challenge.find(params[:relationship][:followed_id])
		current_user.follow_challenge!(@challenge)
		redirect_to root_path
	end

	def destroy
		@challenge = Relationship.find(params[:id]).followed_id
		current_user.challenge_unfollow!(@challenge)
		redirect_to root_path
	end

end
