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
		params.require(:challenge).permit(:title, :category, :description, :top_three_flag, :attachment, :quick_fix)
	end

	def index
		if params[:search]
    		@challenge = current_user.challenges.search(params[:search]).order("created_at DESC")
		elsif current_user.acct_type == 'admin'
			@challenge = Challenge.all
		elsif current_user.acct_type == 'innovator'
			@challenge = Challenge.where(:top_three_flag => true) 
		end
	end

	def show
		@challenge = Challenge.find(params[:id])
	end

	def search_category
		@current_challenge = Challenge.find(params[:id])
		@challenge = current_user.challenges.find_by_sql("SELECT * FROM challenges WHERE category = '#{@current_challenge.category}'")
	end

	def add_top_three
		@challenge = Challenge.find(params[:id])
		@all_flags = Challenge.where(top_three_flag: true).count
		@post_owner = User.find("#{@challenge.user_id}")
		if @challenge.top_three_flag == false && @all_flags < 3 && current_user.acct_type == 'admin'
			@challenge.update_attribute(:top_three_flag, true)
			update_score_user(@post_owner, 'select_challenge')
			redirect_to "/challenges"
			flash[:success] = "#{@challenge.title} is now live!"
		elsif @challenge.top_three_flag == true && @challenge.voting_stage == false && current_user.acct_type == 'admin'
			@challenge.update_attribute(:top_three_flag, false)
			downgrade_score(@post_owner, 'select_challenge')
			redirect_to "/challenges"
			flash[:danger] = "The live flag has been removed for #{@challenge.title}"
		else
			redirect_to "/challenges"
			flash[:danger] = "You can have no more than 3 live challenges at one time."
		end
	end

	def voting_stage
		@challenge = Challenge.find(params[:id])
		if @challenge.top_three_flag == true && @challenge.voting_stage == false
			@challenge.update_attribute(:voting_stage, true)
			redirect_to '/challenges'
			flash[:success] = 'Voting stage initiated: challenge is now CLOSED'
		elsif @challenge.top_three_flag == true && @challenge.voting_stage == true
			@challenge.update_attribute(:voting_stage, false)
			redirect_to '/challenges'
			flash[:danger] = 'Voting stage removed: challenge has been REOPENED'
		end
	end

	def participate_stage
		@challenge = Challenge.find(params[:id])
		if @challenge.top_three_flag == true && @challenge.voting_stage == true && @challenge.participate_stage == false
			@challenge.update_attribute(:participate_stage, true)
			redirect_to "/challenges"
			flash[:success] = "Challenge is now in the participate stage"
		elsif @challenge.top_three_flag == true && @challenge.voting_stage == true && @challenge.participate_stage == true
			@challenge.update_attribute(:participate_stage, false)
			redirect_to "/challenges"
			flash[:danger] = "Challenge has been removed from the participate stage"
		end
	end

  	def edit
  		@challenge = Challenge.find(params[:challenge_id])
  		if current_user.id == @challenge.user_id
  			@challenge = Challenge.find(params[:challenge_id])
  		else
  			redirect_to root_path
  			flash[:danger] = "You do not have permissions to view this page."
  		end
  	end

  	def update
  		@challenge = Challenge.find(params[:id])
  		if @challenge.update_attributes(challenge_params)
  			flash[:success] = "Challenge updated!"
  			redirect_to root_path
  		else
  			render 'edit'
  		end
  	end
end
