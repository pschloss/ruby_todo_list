# Classes
class List

	attr_reader :all_tasks

	def initialize
		@all_tasks = []
	end

	def add_task(task)
		@all_tasks << task
	end

	def show_list
		@all_tasks.each { |task| puts task.description }
	end

	def read_tast_from_file
	end

	def write_list_to_file
	end

	def delete_task
	end

	def update_task
	end

end


class Task

	attr_reader :description

	def initialize(description)
		@description = description
	end

end



#actions
if __FILE__ == $PROGRAM_NAME
	my_list = List.new
	puts 'You have created a new list'

	my_list.add_task(Task.new("Go to work."))
	puts 'You have added a new task'

	my_list.show_list
end
