require "minitest/autorun"
require_relative "../lib/card"

class CardTest < Minitest::Test
  def test_that_card_has_a_suit
    card = Card.new(:Ace, :Spades)
    assert_equal card.suit, :Spades
  end

  def test_that_card_has_a_rank
    card = Card.new(:Ace, :Spades)
    assert_equal card.rank, :Ace
  end

  def test_that_ace_is_low
    ace = Card.new(:Ace, :Spades)
    two = Card.new(2, :Hearts)

    assert two.greater_than?(ace)
    refute ace.greater_than?(two)
  end

  def test_face_card_ranks
    ten = Card.new(10, :Hearts)
    jack = Card.new(:Jack, :Spades)
    queen = Card.new(:Queen, :Diamonds)
    king = Card.new(:King, :Clubs)

    assert king.greater_than?(queen)
    assert queen.greater_than?(jack)
    assert jack.greater_than?(ten)
  end
end
