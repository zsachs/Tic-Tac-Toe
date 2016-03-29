# -*- coding: utf-8 -*-

class Board

	attr_accessor :board
	
	def initialize(args)
		args = defaults.merge(args)
		@board = args[:board]
	end

	def defaults
		{:board => [1,2,3,4,5,6,7,8,9]}
	end

	def display
		puts "|_#{board[0]}_|_#{board[1]}_|_#{board[2]}_|\n|_#{board[3]}_|_#{board[4]}_|_#{board[5]}_|\n|_#{board[6]}_|_#{board[7]}_|_#{board[8]}_|"
	end

	def valid_spots
		valid_spots = []

		board.each_with_index do |spot, index|
			if spot != 'X' && spot != 'O'
				valid_spots.push(index)
			end
		end

		return valid_spots
	end

	def mark(spot, marker)
		board[spot-1] = marker
	end

	def win?
		if board[0..2].uniq.length == 1 ||
			board[3..5].uniq.length == 1 ||
			board[6..8].uniq.length == 1 ||
			[board[0], board[3], board[6]].uniq.length == 1 ||
			[board[1], board[4], board[7]].uniq.length == 1 ||
			[board[2], board[5], board[8]].uniq.length == 1 ||
			[board[0], board[4], board[8]].uniq.length == 1 ||
			[board[2], board[4], board[6]].uniq.length == 1
			true
		else
			false
		end
	end

	def draw?
		if win?
			false
		else
			board.all? {|b| b == 'X' || b == 'O' }
		end
	end
end
