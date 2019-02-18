require 'json'
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ("a".."z").to_a
    @grid = []
    10.times do
      @grid << @letters.sample
    end
    @grid
  end

  def score
    @attempt = params[:word]
    @new_grid = params[:grid].split("")
    if found(@attempt)
      if included?(@new_grid, @attempt)
        @results = "Well done"
      else
        @results = "Not in the grid"
      end
    else
      @results = "Not a valid english word"
    end
  end

  def found(attempt)
    JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{attempt}").read)['found']
  end

  def included?(new_grid, attempt)
    chars = attempt.chars
    chars.all? do |letter|
      chars.count(letter) <= new_grid.count(letter)
    end
  end
end
