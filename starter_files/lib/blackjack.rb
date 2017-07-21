require_relative 'deck'
require 'pry'

class Game
  attr_accessor :player_hand, :dealer_hand, :card_deck, :player_hand_value, :dealer_hand_value, :bank

  def initialize
    @bank = 100
    @player_hand = []
    @dealer_hand = []
    @card_deck = Deck.new
    @card_deck.shuffle
  end

  def game_start

    if @bank < 10
      puts "Looks like you're broke. We're done here!"
      exit
    end

    puts "Let's play some Blackjack! You have $#{@bank} in the bank and it costs $10 to play a hand."

    puts "Are you in? (y/n)"

    choice = gets

    if choice.chomp == "y"
      puts "Then let's get started!"
      deal
    elsif choice.chomp == "n"
      puts "Sorry to see you go..."
      exit
    else
      puts "I didn't understand you.  What was that again?"
      game_start
    end
  end

  def deal
    @card_deck = Deck.new
    @card_deck.shuffle
    @player_hand = []
    @dealer_hand = []
    @bank -= 10

    2.times do
      @player_hand << @card_deck.draw
      @dealer_hand << @card_deck.draw
    end
    puts "Your hand is the #{@player_hand.first} and the #{@player_hand.last}, with a value of #{hand_value(@player_hand)}."
    puts "The dealer is showing a #{@dealer_hand.last}."

      hit_or_stand
  end

  def hit_or_stand

    puts "Hit or stand?"

    choice = gets

    if choice.chomp == "hit"
      hit
    elsif choice.chomp == "stand"
      hand_over
    else
    puts "I didn't understand you.  What was that again?"
    hit_or_stand
    end
  end

  def limit_check
    if hand_value(@player_hand) > 21
      puts "The player busted with a hand value of #{hand_value(@player_hand)}. You lose!"
      game_start
    end
  end

  def hand_display(hand)
    @p_hand = hand.collect(&:to_s).join(', ')
  end

  def hand_value(hand)

    val = hand.reduce(0) do |acc, obj|
      acc = acc + obj.value
    end
    val
  end

  def hit
    @player_hand << @card_deck.draw
    # puts @player_hand
    puts "Your current hand: #{hand_display(@player_hand)} with a value of #{hand_value(@player_hand)}."
    limit_check
    hit_or_stand
  end

  def hand_over
    while hand_value(@dealer_hand) < 17
      @dealer_hand << @card_deck.draw
    end
    if hand_value(@dealer_hand) > hand_value(@player_hand) && hand_value(@dealer_hand) < 22
      lose
    else
      win
    end
  end

  def win
    puts "Your final hand of #{hand_display(@player_hand)} wins with a value of #{hand_value(@player_hand)} over the dealer's hand of #{hand_display(@dealer_hand)} with a value of #{hand_value(@dealer_hand)}."

    puts "Congrats!  You win $20."

    @bank += 20

    game_start
  end

  def lose
    puts "Your final hand of #{hand_display(@player_hand)} wins with a value of #{hand_value(@player_hand)} over the dealer's hand of #{hand_display(@dealer_hand)} with a value of #{hand_value(@dealer_hand)}."

    puts "You lose!  You lost your bet."

    game_start

  end

end

game = Game.new
game.game_start

binding.pry
