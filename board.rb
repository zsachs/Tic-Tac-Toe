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
		self.board.each_with_index do |spot, index|
			if spot != 'X' && spot != 'O'
				valid_spots.push(index)
			end
		end
		return valid_spots
	end

	def mark(spot, marker)
		self.board[spot-1] = marker
	end

	def win?
		if self.board[0..2].uniq.length == 1 ||
			self.board[3..5].uniq.length == 1 ||
			self.board[6..8].uniq.length == 1 ||
			[self.board[0], self.board[3], self.board[6]].uniq.length == 1 ||
			[self.board[1], self.board[4], self.board[7]].uniq.length == 1 ||
			[self.board[2], self.board[5], self.board[8]].uniq.length == 1 ||
			[self.board[0], self.board[4], self.board[8]].uniq.length == 1 ||
			[self.board[2], self.board[4], self.board[6]].uniq.length == 1
			true
		else
			false
		end
	end

	def draw?
		if self.win?
			false
		else
			self.board.all? {|b| b == 'X' || b == 'O' }
		end
	end
end
