require_relative "card"

class Deck

  def initialize
    @card_holder = []
    build_deck
  end

  attr_accessor :card_holder

  def build_deck
    Card.suits.each do |suit|
      Card.faces.each do |face|
        @card_holder << Card.new(face, suit)
      end
    end
  end

  def draw
    @card_holder.shift
  end

  def shuffle
    @card_holder.shuffle!
  end



end
