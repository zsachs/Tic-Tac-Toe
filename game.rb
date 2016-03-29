# -*- coding: utf-8 -*-

class Game

	attr_accessor :grid, :turn, :player_one, :player_two

	def initialize
		@grid = Board.new({})
		@turn = 1
		@player_one = nil
		@player_two = nil
	end

	def get_players
		puts "How many of you want to play today?"
		players = $stdin.gets.chomp.to_i

		until players > 0
			puts "Please enter a positive integer."
			players = $stdin.gets.chomp.to_i
		end

		return players
	end

	def set_players(number)
		if number > 2
			puts "Looks like we've got a tournament."
			puts "Two of you decide who plays 'X' and who plays 'O'."
			puts "Who will play 'X'?"
			self.player_one = Human.new('X', $stdin.gets.chomp)
			puts "And who is the opponent?"
			self.player_two = Human.new('O', $stdin.gets.chomp)
			puts "It's on like Donkey Kong!"
		elsif number == 2
			puts "Alright."
			puts "Who will play 'X'?"
			self.player_one = Human.new('X', $stdin.gets.chomp)
			puts "And who is the opponent?"
			self.player_two = Human.new('O', $stdin.gets.chomp)
			puts "It's on like Donkey Kong!"
		elsif number == 1
			puts "What is your name?"
			name = $stdin.gets.chomp
			puts "Your challenge has been accepted #{name}."
			puts "Would you like to play 'X' or 'O'?"
			marker = $stdin.gets.chomp.upcase

			until marker == 'X' || marker == 'O'
				puts "Please enter 'X' or 'O'."
				marker = $stdin.gets.chomp.upcase
			end

			if marker == 'X'
				self.player_one = Human.new('X', name)
				self.player_two = Computer.new('O')
			elsif marker == 'O'
				self.player_one = Computer.new('X')
				self.player_two = Human.new('O', name)
			else
				puts "ERROR: marker didn't set right."
				exit(1)
			end
		else
			puts "ERROR: needs an integer."
			exit(1)
		end
	end

	def switch_turn
		self.turn *= -1
	end

	def next_move
		valid = grid.valid_spots

		if turn > 0
			if player_one.instance_of? Human
				grid.display
				spot = player_one.move

				until valid.include?(spot-1)
					puts "Please choose a valid unmarked spot."
					spot = player_one.move
				end

				grid.mark(spot, player_one.marker)
			else
				spot = player_one.move(grid)
				puts "The machine has moved to #{spot + 1}"
				grid.mark(spot + 1, player_one.marker)
			end
		else
			if player_two.instance_of? Human
				grid.display
				spot = player_two.move

				until valid.include?(spot-1)
					puts "Please choose a valid unmarked spot."
					spot = player_two.move
				end

				grid.mark(spot, player_two.marker)
			else
				spot = player_two.move(grid)
				puts "The machine has moved to #{spot + 1}"
				grid.mark(spot + 1, player_two.marker)
			end
		end

		switch_turn
	end

	def gameover
		if grid.win? || grid.draw?
			true
		else
			false
		end
	end

	def start
		puts "Welcome to Tic-Tac-Toe."
		players = get_players
		set_players(players)

		until gameover
			next_move
		end

		if grid.draw?
			puts "You'll have to play again to see who takes out the trash."
		else
			if turn < 0
				if player_one.instance_of? Human
					puts "You've won, #{player_one.name}!"
				else
					puts "The machines grow stronger."
				end
			else
				if player_two.instance_of? Human
					puts "You've won, #{player_two.name}!"
				else
					puts "The machines grow stronger."
				end
			end

			grid.display
		end
	end

end
