# -*- coding: utf-8 -*-
require './board.rb'
require './player.rb'
require './game.rb'

# does the board initialize, display, and mark?
def test_board
	grid = Board.new({})
	grid.display
	grid.mark(3,'X')
	grid.display
	grid.mark(9,'X')
	grid.display
end

# does Board#valid_spots work?
def test_valid_spots
	grid = Board.new({})
	grid.board = ['X', 'O', 3, 4, 'O', 'X', 7, 8, 9]
	puts "Is this 2, 3, 6, 7, 8?\n#{grid.valid_spots}."
end

# does Board#win? work?
def test_win
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

# does Board#draw? work?
def test_draw
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

# does player work?
def test_player
	jigsaw = Player.new("dummy")
	puts jigsaw.marker
	jigsaw.move
end

# do humans work?
def test_human
	player_one = Human.new("XOXO", "TommyBoy")
	puts "Placing #{player_one.name}'s marker #{player_one.marker} at #{player_one.move}."
end

# do computers work
def test_computer
	player_two = Computer.new("0101 0110")
	puts "Placing marker #{player_two.marker} at #{player_two.move([0])}."
end

# does Computer#scores_for_minimax work?
def test_scores
	player_one = Computer.new('X')
	puts "#{player_one.scores_for_minimax(0, false)} ?= -10"
	puts "#{player_one.scores_for_minimax(0, true)} ?= 10"
	puts "#{player_one.scores_for_minimax(3, false)} ?= -10"
	puts "#{player_one.scores_for_minimax(3, true)} ?= 7"
	end

# does Computer#children work?
def test_children
	player_one = Computer.new('X')
	grid = Board.new(:board => ['O', 2, 'X', 'X', 5, 6, 'X', 'O', 'O'])
	puts "Start with this board node:"
	grid.display
	kids = player_one.children(grid, true)
	puts "Does kids have the right length? #{kids.length == 3}."
	kids.each_with_index do |child, index|
		puts "Child \##{index}"
		child.display
	end
end

# does Computer#minimax work?
def test_minimax
	player_one = Computer.new('O')
	grid = Board.new(:board => [1, 'X', 3, 4, 5, 'X', 'O', 'O', 'X'])
	puts "Start with this board node:"
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
end

# does game initialize?
def test_game
	jeu = Game.new
	puts "The grid #{jeu.grid}."
	puts "Player One #{jeu.player_one}."
	puts "Player Two #{jeu.player_two}."
end

# does Game#get_players work
def test_get_players
	puts Game.new.get_players
end

# does Game#set_players work
def test_set_players
	jeu = Game.new
	puts "Testing set_players with other than a positive integer will exit."
	print "Enter anything to test that. > "
	non = $stdin.gets.chomp
	possible_numbers = [1,2,3]
	if non.length != 0
		possible_numbers.push(non)
	end

	possible_numbers.each do |number|
		puts "Testing set_players with #{number} players."
		two_players = jeu.set_players(number)
		two_players.each do |player|
			if player.kind_of? Player
				# already throws error here for number not a positive integer
			else
				puts "ERROR: players not set despite proper number."
			end
		end
	end
end

# does Game#start work
def test_start
end

#test_board
#test_valid_spots
#test_win
#test_draw
#test_player
#test_human
#test_computer
#test_scores
#test_children
#test_minimax
#test_game
#test_get_players
#test_set_players
#test_start

battle = Game.new
battle.start
