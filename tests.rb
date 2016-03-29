# -*- coding: utf-8 -*-

class Tests

	require './board.rb'
	require './player.rb'
	require './game.rb'

	def run
		puts "Implement run() in a subclass."
	end
end


class Board_tests < Tests

	def run
		test_board
		test_valid_spots
		test_win
		test_draw
	end

	def test_board
		puts "Testing a new Board."
		grid = Board.new({})
		grid.display
		puts "'X' mark 3:"
		grid.mark(3,'X')
		grid.display
		puts "'O' mark 9:"
		grid.mark(9,'O')
		grid.display
	end

	def test_valid_spots
		puts "Testing Board#valid_spots."
		grid = Board.new(:board => ['X', 'O', 3, 4, 'O', 'X', 7, 8, 9])
		grid.display
		puts "It works on this board? #{[2, 3, 6, 7, 8]==grid.valid_spots}."
	end

	def test_win
		puts "Testing Board#win?."
		grid = Board.new({})
		puts "Blank wins?"
		puts grid.win?
		grid.board = ['X', 'O', 3, 4, 'O', 'X', 7, 8, 9]
		puts "Each marked twice wins?"
		puts grid.win?
		grid.board = ['X', 2, 'O', 'O', 'X', 6, 7, 8, 'X']
		puts "'X' wins."
		puts grid.win?
		grid.board = ['O', 'X', 'O', 'X', 'X', 6, 'X', 'O', 9]
		puts "Non-winner wins?"
		puts grid.win?
	end

	def test_draw
		puts "Testing Board#draw?."
		grid = Board.new({})
		puts "Blank draws?"
		puts grid.draw?
		grid.board = ['X', 2, 'O', 'O', 'X', 6, 7, 8, 'X']
		puts "'X' wins draws?"
		puts grid.draw?
		grid.board = ['X', 'O', 'X', 'X', 'O', 'X', 'O', 'X', 'O']
		puts "Draw draws."
		puts grid.draw?
	end
end


class Player_tests < Tests

	def run
		puts "Testing Player will exit. Enter any character to do so.\n>"
		basic = $stdin.gets.chomp
		if basic.length != 0
			test_player
		end
		test_human
		test_computer
		test_scores
		test_children
		test_minimax
		test_computer_move
	end

	def test_player
		puts "Testing a new Player."
		jigsaw = Player.new("dummy")
		puts jigsaw.marker
		jigsaw.move
	end

	def test_human
		puts "Testing a new Human."
		player_one = Human.new("XOXO", "TommyBoy")
		puts "Placing #{player_one.name}'s marker #{player_one.marker} at #{player_one.move}."
	end

	def test_computer
		puts "Testing a new Computer"
		player_two = Computer.new("0101 0110")
		puts "Computer has a marker #{player_two.marker}."
	end

	def test_scores
		puts "Testing Computer#scores_for_minimax. Expect all true."
		player_one = Computer.new('X')
		puts "#{player_one.scores_for_minimax(0, false) == -10}"
		puts "#{player_one.scores_for_minimax(0, true) == 10}"
		puts "#{player_one.scores_for_minimax(3, false) == -10}"
		puts "#{player_one.scores_for_minimax(3, true) == 7}"
	end

	def test_children
		puts "Testing Computer#children."
		player_one = Computer.new('X')
		grid = Board.new(:board => ['O', 2, 'X', 'X', 5, 6, 'X', 'O', 'O'])
		puts "Start with this board-node:"
		grid.display
		kids = player_one.children(grid, true)
		puts "Does kids have the right length? #{kids.length == 3}."

		kids.each_with_index do |child, index|
			puts "Child \##{index+1}"
			child.display
		end
	end

	def test_minimax
		puts "Testing Computer#minimax."
		player_one = Computer.new('O')
		grid = Board.new(:board => [1, 'X', 3, 4, 5, 'X', 'O', 'O', 'X'])
		puts "Start with this board-node:"
		grid.display
		valid = grid.valid_spots
		puts "It has valid moves #{valid}."
		scores = []

		player_one.children(grid, true).each do |spot|
			puts "This child is:"
			spot.display
			score = player_one.minimax(spot, 1, false)
			puts "And has minimax score #{score}."
			scores.push(score)
		end

		puts "Minimax on the node is max of child scores? #{scores.max==player_one.minimax(grid,0,true)}."
	end

	def test_computer_move
		puts "Testing Computer#move."
		player_two = Computer.new('X')
		spot = player_two.move(Board.new(:board => [1, 'X', 3, 4, 5, 'X', 'O', 'O', 'X']))
		puts "This Computer has moved to #{spot}."
	end
end


class Game_tests < Tests

	def run
		test_game
		test_get_players
		test_set_players
	end

	def test_game
		puts "Testing a new Game."
		jeu = Game.new
		puts "The grid #{jeu.grid}."
		puts "Player One #{jeu.player_one}."
		puts "Player Two #{jeu.player_two}."
	end

	def test_get_players
		puts "Testing Game#get_players."
		puts Game.new.get_players
	end

	def test_set_players
		puts "Testing Game#set_players."
		jeu = Game.new
		print "To test other than a positive integer, enter it here. The test will exit.\n>"
		non = $stdin.gets.chomp
		possible_numbers = [1,2,3]
		if non.length != 0
			possible_numbers.push(non)
		end

		possible_numbers.each do |number|
			puts "Testing with #{number} players."
			jeu.set_players(number)

			if jeu.player_one.kind_of?(Player) && jeu.player_two.kind_of?(Player)
	# 			already throws ArgumentError here for number not a positive integer
				puts "Successfully set players."
			else
				puts "ERROR: players not set despite proper number."
			end
		end
	end
end

Tests.new.run
Board_tests.new.run
Player_tests.new.run
Game_tests.new.run
