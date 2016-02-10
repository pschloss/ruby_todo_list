# Modules
module Menu
	def menu
		puts "Please choose from the following list:
	(A) Add a task
	(S) Show your ToDo list
	(W) Write ToDo list to file
	(Q) Quit"
	end

	def show
		menu
	end
end

module Promptable
	def prompt(text = 'What would you like to do?', symbol = ":>")
		print "#{text} #{symbol} "
		gets.chomp.downcase
	end

end


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

	def read_task_from_file
	end

	def write_list_to_file(filename)
		IO.write(filename, @all_tasks.map(&:to_s).join("\n"))
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

	def to_s
		@description
	end

end



#actions
if __FILE__ == $PROGRAM_NAME

	include Menu
	include Promptable

	my_list = List.new

	user_input = ""

	menu

	until (user_input = prompt) == 'q' do

		case user_input
			when 'a'
				my_list.add_task(Task.new(prompt('What is the task you would like to add?')))
			when 's'
 				my_list.show_list
			when 'w'
				my_list.write_list_to_file(prompt("What is the file that you want to write to?"))
			else
				puts "Sorry I don't know that option"
		end
	end


	puts 'Outro - Thanks for using the menu system!'
end
