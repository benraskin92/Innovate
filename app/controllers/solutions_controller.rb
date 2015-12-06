class SolutionsController < ApplicationController
	before_action :authenticate_user!

	def new
		@challenge = Challenge.find(params[:challenge_id])
		if @challenge.voting_stage == false && @challenge.top_three_flag == true
			@solution = Solution.new
		else
			redirect_to "/challenges"
			flash[:danger] = "This function is not allowed."
		end
	end

	def create
		@solution = Solution.new(solution_params)
		challenge = Challenge.find(params[:challenge_id])
		user = current_user
		@solution.challenge_id = challenge.id
		@solution.user_id = user.id
		if @solution.save
			update_score_user(user, 'solution')
			redirect_to root_path
			flash[:success] = 'Solution has been accepted! You have earned 10 points!'
		else
			render 'new'
		end
	end

	def index
		@challenge = Challenge.find(params[:challenge_id])
		if current_user.acct_type == 'innovator'
			@solution = Solution.find_by_sql("SELECT * FROM solutions WHERE challenge_id = #{@challenge.id} AND top_flag = 't'")
		elsif current_user.acct_type == 'admin'
			@solution = Solution.find_by_sql("SELECT * FROM solutions WHERE challenge_id = #{@challenge.id}")
		end
	end

	def top_flag
		@solution = Solution.find(params[:id])
		@challenge1 = Challenge.where(id: "#{@solution.challenge.id}")
		# @challenge = Challenge.find_by_sql("SELECT * FROM challenges WHERE id = #{@solution.challenge_id}")
		# @three_flagss = Solution.find_by_sql("SELECT * FROM solutions s WHERE s.challenge_id = #{@challenge1.id} AND s.top_flag = 'true'")
		@three_flags = Solution.where(challenge_id: "#{@solution.challenge_id}", top_flag: true)
		if current_user.acct_type == 'admin' && @solution.top_flag == false && @three_flags.count < 3
			@solution.update_attribute(:top_flag, true)
			redirect_to(:back)
			flash[:success] = 'Solution is now flagged!'
		elsif current_user.acct_type == 'admin' && @solution.top_flag == true
			@solution.update_attribute(:top_flag, false)
			redirect_to(:back)
			flash[:danger] = 'Solution is now NOT flagged!'
		else
			redirect_to(:back)
			flash[:danger] = 'No more than 3 solutions can be flagged!'
		end
	end

	def solution_params
		params.require(:solution).permit(:solution, :attachment)
	end

end