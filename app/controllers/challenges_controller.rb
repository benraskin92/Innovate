class ChallengesController < ApplicationController

	before_action :authenticate_user!


	def new
		@challenge = current_user.challenges.new
	end

	def create
		@challenge = Challenge.new(challenge_params)
		@challenge.user_id = current_user.id
		if @challenge.save
			update_score
			redirect_to root_path
			flash[:success] = 'Challenge has been accepted!'
		else
			render 'new'
		end
	end

	def challenge_params
		params.require(:challenge).permit(:title, :category, :description)
	end

	def index
		if params[:search]
    		@challenge = current_user.challenges.search(params[:search]).order("created_at DESC")
		elsif current_user.acct_type == 'admin'
			@challenge = Challenge.all
		elsif current_user.acct_type == 'innovator' 
			@challenge = current_user.challenges
		end
	end

end
