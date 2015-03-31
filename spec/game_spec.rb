require "spec_helper"

module Hangman
	describe Game do
		context "#initialize" do
			it "randomly selects a word 5-12 chars" do
				#puts Dir.pwd
				game = Game.new
				expect(game.word.length).to be_between(5, 12).inclusive
			end

			skip it "gives the same number of clues as word.length" do
				game = Game.new
				expect(game.word.length).to eq(game.clues.length)
			end

		end

	end
end
