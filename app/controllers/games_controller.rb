require 'open-uri'
require 'json'

class GamesController < ApplicationController
  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @user_word = params[:word]
    @response = valid_word(@user_word) # {"found"=>true, "word"=>"teacher", "length"=>7}
    @letters = params['letters']
    @valid_word = valid_word(@user_word)
    @valid_letter = valid_letter(@user_word, @letters)
  end

  private

  def valid_word(word)
    @url = 'https://wagon-dictionary.herokuapp.com/'
    @result = JSON.parse(URI(@url + word).read)
    @result['found'] # true or false
  end

  def valid_letter(word, letters)
    word.upcase!
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
