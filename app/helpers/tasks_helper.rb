module TasksHelper
	def all_tasks_complete
		# if all tasks that belong to this goal are complete
			# update the goals :completed_at field to the date

			@goal = Goal.find(params[:id])
			@my_tasks = @goal.tasks 

			@completed_tasks = @my_tasks.map { |completed| completed.completed_at }

			if @completed_tasks.all?
				@goal.update_attribute(:completed_at, Time.zone.now)
			end

		## Below is the old method that was created during final project week.

		# @tasks_completed = @tasks.map { |task| !task.completed_at.nil? }
  	#   # This is iterate through each task and see if each completed_at attribute 
  	#   # is nil? (true == completed & false == incomplete)

  	#   # when a tasks are first created, all completed_at values will be true because they are nil
	  #   if @tasks_completed.any?
	  #     if @tasks_completed.all?
	  #       @goal.update_attribute(:completed_at, Time.zone.now)
	  #     end
	  #   end

	end
end
