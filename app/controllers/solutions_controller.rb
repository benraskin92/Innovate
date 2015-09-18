class SolutionsController < ApplicationController
	before_action :authenticate_user!

	def new
		@challenge = Challenge.find(params[:challenge_id])
		@solution = Solution.new
	end

	def create
		@solution = Solution.new(solution_params)
		challenge = Challenge.find(params[:challenge_id])
		user = current_user
		@solution.challenge_id = challenge.id
		@solution.user_id = user.id
		if @solution.save
			redirect_to root_path
			flash[:success] = 'Solution has been accepted!'
		else
			render 'new'
		end
	end

	def index
		@challenge = Challenge.find(params[:challenge_id])
		@solution = Solution.find_by_sql("SELECT * FROM solutions WHERE challenge_id = #{@challenge.id}")
	end

	def solution_params
		params.require(:solution).permit(:solution, :attachment)
	end

end