module GoalsHelper
	def tasks_left
		@goal = Goal.find(params[:id])
		@tasks = @goal.tasks
  	@num_tasks = @tasks.length
  	# Get the count of how many tasks a certain goal has
  end
end
