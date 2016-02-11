# Modules
module Menu
	def menu
		puts "Please choose from the following list:
	(A) Add a task
	(S) Show your ToDo list
	(W) Write ToDo list to file
	(R) Read ToDo list from a file
	(D) Delete a ToDo item from list
	(U) Update an item from the ToDo list
	(T) Toggle whether a task is completed
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
		@all_tasks.each_with_index { |task, index| puts "#{index+1} #{task.description}" }
	end

	def read_list_from_file(filename)
		lines = IO.readlines(filename)
		lines.each do |l|
			line_array = l.strip.split(" : ")
			completed = line_array[0] == "[X]" ? true : false
			@all_tasks << Task.new(line_array[1], completed)
		end
	end

	def write_list_to_file(filename)
		machinified = @all_tasks.map(&:to_machine).join("\n")
		IO.write(filename, machinified)
	end

	def delete_task(task_number)
		@all_tasks.delete_at(task_number-1)
	end

	def update_task(task_number, new_task)
		@all_tasks[task_number-1] = Task.new(new_task)
	end

	def toggle_task(task_number)
		@all_tasks[task_number-1].status = !@all_tasks[task_number-1].completed?
	end

end


class Task

	attr_reader :description
	attr_accessor :status

	def initialize(description, status=false)
		@description = description
		@status = status
	end

	def to_s
		@description
	end

	def completed?
		@status
	end

	def to_machine
		"#{represent_status} : #{to_s}"
	end

	private
	def represent_status
		"#{completed? ? '[X]' : '[ ]'}"
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
			when 'r'
				my_list.read_list_from_file(prompt("What is the file that you want to read from?"))
			when 'd'
				my_list.delete_task(prompt("Which task number would you like to delete?").to_i)
			when 'u'
				task_number = prompt("Which task number would you like to delete?").to_i
				new_task = prompt("What should the task be?")
				my_list.update_task(task_number, new_task)
			when 't'
				my_list.toggle_task(prompt("Which task number would you like to toggle?").to_i)
			else
				puts "Sorry I don't know that option"
		end
	end


	puts 'Outro - Thanks for using the menu system!'
end
