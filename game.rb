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
			one = Human.new('X', $stdin.gets.chomp)
			puts "And who is the opponent?"
			two = Human.new('O', $stdin.gets.chomp)
			puts "It's on like Donkey Kong!"
		elsif number == 2
			puts "Alright."
			puts "Who will play 'X'?"
			one = Human.new('X', $stdin.gets.chomp)
			puts "And who is the opponent?"
			two = Human.new('O', $stdin.gets.chomp)
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
				one = Human.new('X', name)
				two = Computer.new('O')
			elsif marker == 'O'
				one = Computer.new('X')
				two = Human.new('O', name)
			else
				puts "ERROR: marker didn't set right."
				exit(1)
			end
		else
			puts "ERROR: needs an integer."
			exit(1)
		end
		return [one, two]
	end

	def switch_turn
		self.turn *= -1
	end

	def next_move
		valid = self.grid.valid_spots

		if self.turn > 0
			if self.player_one.instance_of? Human
				self.grid.display
				spot = self.player_one.move
				until valid.include?(spot-1)
					puts "Please choose a valid unmarked spot."
					spot = self.player_one.move
				end
				self.grid.mark(spot, self.player_one.marker)
			else
				spot = self.player_one.move(self.grid)
				puts "The machine has moved to #{spot + 1}"
				self.grid.mark(spot + 1, self.player_one.marker)
			end
		else
			if self.player_two.instance_of? Human
				self.grid.display
				spot = self.player_two.move
				until valid.include?(spot-1)
					puts "Please choose a valid unmarked spot."
					spot = self.player_two.move
				end
				self.grid.mark(spot, self.player_two.marker)
			else
				spot = self.player_two.move(self.grid)
				puts "The machine has moved to #{spot + 1}"
				self.grid.mark(spot + 1, self.player_two.marker)
			end
		end

		self.switch_turn
	end

	def gameover
		if self.grid.win? || self.grid.draw?
			true
		else
			false
		end
	end

	def start
		puts "Welcome to Tic-Tac-Toe."
		players = self.get_players
		self.player_one, self.player_two = self.set_players(players)

		until self.gameover
			self.next_move
		end

		if self.grid.draw?
			puts "You'll have to play again to see who takes out the trash."
		else
			if self.turn < 0
				if self.player_one.instance_of? Human
					puts "You've won, #{self.player_one.name}!"
				else
					puts "The machines grow stronger."
				end
			else
				if self.player_two.instance_of? Human
					puts "You've won, #{self.player_two.name}!"
				else
					puts "The machines grow stronger."
				end
			end
			self.grid.display
		end

	end

end
