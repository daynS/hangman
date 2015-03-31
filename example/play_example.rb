require_relative "../lib/hangman.rb"
require 'yaml'

puts "Welcome to hangman"

puts "New game (n) or saved game (s)?"
answer = gets.chomp
if answer == 's'
	puts "Game name?"
	game_name = gets.chomp
	game_name << ".yml"

	load_game = File.open("./saves/#{game_name}", 'r') { |file| file.read }
	game = YAML::load(load_game)
	game.play

else
	new_game = Hangman::Game.new.play
end