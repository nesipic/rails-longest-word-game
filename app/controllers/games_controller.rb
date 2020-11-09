require 'open-uri'
class GamesController < ApplicationController
  def new
    alphabet = ("a".."z").to_a
    index = alphabet.length
    @letters = []
    10.times do @letters << alphabet[rand(0...index)] 
    end
  end

  def score
    @letters_ten = params[:letters]
    @user_input = params[:word]
  
    @test3 = @user_input.chars.all? { |letter| @user_input.count(letter) <= @letters_ten.split.count(letter) }
  
    @test2 = english?(@user_input)
      win = @test2 && @test3
    if @test3 == false
      @results = "Sorry, #{@user_input} is not made from grid!"
    elsif @test2 == false
      @results = "Sorry, #{@user_input} is not an english word!"
    elsif win == true
      @results = "Congratulation! Your #{@user_input} is english word and it is made from grid!"
    end
  end
    private
    def english?(word)
      url = "https://wagon-dictionary.herokuapp.com/#{word}"
      response_serialized = open(url)
      response_data = JSON.parse(response_serialized.read)
        if response_data["found"]
          return true
        else
         return false
        end
    end
end
