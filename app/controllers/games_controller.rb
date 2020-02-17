require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def read(word)
    # Combines all of the parse steps into one step.
    # The found at the end looks for the the "found" key in hash.
    JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{word}").read)["found"]
  end

  def new
    alphabet = 'abcdefghijklmnopqrstuvwxyz'.chars
    @letters = []
    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    @word = params[:word]
    @valid = ""
    if read(@word) == true && is_included(params[:letters], @word)
      @total2 = session[:score_id] += @word.length
      @valid = "Congratulations! #{@word} is a valid english word!"
    else
      @valid = "Sorry but #{@word} is not a valid word or not in grid"
    end
  end

  def is_included(arr, word)
    letters1 = word.chars
    @arr = arr.split(" ")
    letters1.each do |letter|
      if @arr.include?(letter)
        @arr.delete_at(@arr.index(letter) || @arr.length)
      else
        return false
      end
    end
  end

# Need to fix this method
  def reset
    session[:score_id] = 0
  end
end
