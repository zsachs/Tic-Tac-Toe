# -*- coding: utf-8 -*-
class Player
	attr_accessor :marker

	def initialize(marker)
		@marker = marker
	end

	def move
		puts "Player move is not yet configured. Implement it in a subclass."
		exit(1)
	end
end


class Human < Player
	attr_accessor :name

	def initialize(marker, name)
		super(marker)
		@name = name
	end

	def move
		puts "Make your next move #{self.name}."
		$stdin.gets.chomp.to_i
	end
end

class Computer < Player
	def move(node)
		puts "It is the machine's turn to move."
		# a computer makes moves based on the state of the current board.
		# here say the computer is the maximizing_player
		moves = node.valid_spots
		scores = []
		children(node, true).each do |child|
			scores.push(minimax(child, 1, false))
		end
		best_score_index = scores.each_with_index.max[1]
		spot = moves[best_score_index]
		return spot
	end

	def scores_for_minimax(depth, maximizing_player)
		maximizing_player ? 10 - depth : -10
	end

	def children(node, maximizing_player)
		opponent = (self.marker == 'X' ? 'O' : 'X')
		kids = []
		node.valid_spots.each do |spot|
			board_clone = Board.new(:board => node.board.clone)
			if maximizing_player
				board_clone.mark(spot + 1, self.marker)
			else
				board_clone.mark(spot + 1, opponent)
			end
			kids.push(board_clone)
		end
		return kids
	end

	def minimax(node, depth, maximizing_player)
		if node.win?
			return -1 * scores_for_minimax(depth, maximizing_player)
		end

		if node.draw?
			return 0
		end

		best_score = -1 * scores_for_minimax(0, maximizing_player)
		children(node, maximizing_player).each do |child|
			if maximizing_player
				val = minimax(child, depth + 1, false)
				if val > best_score
					best_score = val
				end
			else
				val = minimax(child, depth + 1, true)
				if val < best_score
					best_score = val
				end
			end
		end

		return best_score
	end
end
