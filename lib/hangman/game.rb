module Hangman
	class Game

		attr_reader :word, :turn_number, :clues, :guesses, :choices, :chances_remaining, :wrong_answers

		def initialize
			@turn_number = 0
			@word = get_word
			@guesses = []
			@choices = ('a'..'z').to_a
			@clues = create_clue(word)
			@wrong_answers = ""
			@chances_remaining = 5
		end

		#Play a game of hangman
		def play
			continue = true
			while continue
				@turn_number += 1
				show_game
				puts "Enter guess or press '1' to save and quit"
				answer = gets.chomp
				if answer == '1'
					save_game
					continue = false
				else
					process_answer(answer.downcase)
				end

				if chances_remaining == 0
					puts "YOU LOSE!"
					puts "The answer was #{word}"
					continue = end_game
				end
				if clues.join == word
					puts word
					puts "You win!"
					continue = end_game
				end
			end
		end

		def guess
		end

		#
		# PRIVATE METHODS!!!!
		#
		private

		def get_word
			words = []
			File.open("words.txt", "r") do |f|
				f.each_line do |word|
					if word.length >= 5 && word.length <= 12
						words << word.delete("\n").downcase
					end
				end
			end
			return words.sample
		end

		def create_clue(word)
			clues = []
			num_of_clues = word.length
			num_of_clues.times do
				clues << "_"
			end
			return clues
		end

		def show_game
			puts ""
			puts "THIS IS THE WORD: #{word}"
			puts ""
			puts "Wrong answers: #{wrong_answers}\nGuesses Left #{chances_remaining}"
			puts "Choices Remaining:"
			puts choices.join(" ")
			puts "Guesses made:"
			puts guesses.join(" ")
			puts "Clues:"
			puts clues.join(" ")
		end

		def process_answer(answer)
			valid_answer = false
			while valid_answer == false
		 		if choices.include?(answer)
		 			valid_answer = true
					add_to_guesses(answer)
					remove_from_choices(answer)
					check_answer(answer)
				else
					puts "Invalid choice. Try again:"
					answer = gets.chomp
				end
			end
		end

		def add_to_guesses(answer)
			guesses << answer
		end

		def remove_from_choices(answer)
			choices.delete(answer)
		end

		def check_answer(answer)
			if word.include?(answer)
				locations = (0 ... word.length).find_all { |i| word[i,1] == answer }
				locations.each do |location|
					#clues[word.index(answer)] = answer
					clues[location] = answer
				end
			else
				puts "Wrong answer"
				wrong_answers << "X"
				@chances_remaining -= 1
			end
		end

		def end_game
			descision = false
			while descision == false
				puts "Play again? y/n"
				answer = gets.chomp
				if answer == 'n'
					puts "Good-bye!"
					return false
				elsif answer == 'y'
					Game.new.play
					return true
				else
					puts "invalid answer! Try again!"
				end
			end
		end

		def save_game
			puts "Name your file:"
			filename = gets.chomp

			File.open("./saves/#{filename}.yml", 'w') do |file|
				file.puts YAML.dump(self)
			end
		end


	end
end