require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @grid = params[:letters]
    @word = params[:word]
   @include = include?(@word, @grid)
    @english_word = english_word?(@word)

  end

  private

  def include?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
