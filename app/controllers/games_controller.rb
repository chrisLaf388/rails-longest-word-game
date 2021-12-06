require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # @letters = (0..10).map{  }
    # ('A'..'Z').sample
    @letters = []
    9.times { @letters << ('A'..'Z').to_a.sample }
    @letters
  end

  def valid_word(word)
    @url = 'https://wagon-dictionary.herokuapp.com/'
    JSON.parse(URI(@url + word).read)
  end

  def valid_letter(word, letters)
    word.upcase!
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def score
    # mot correspond aux lettres donnée
    # mot valid avec le dico anglais
    # recup mot inséré
    @user_word = params[:word]
    @response = valid_word(@user_word) # {"found"=>true, "word"=>"teacher", "length"=>7}
    @letters = params['letters']
    p valid_letter(@user_word, @letters)
    unless valid_letter(@user_word, @letters)
      # if true return le bon affichage
      @message = "mot correct"
    elsif @response["found"] == true
      # affiche erreur mot pas anglais
      @message = "mot pas bon"
    end
    use fonction valid
  end
end
