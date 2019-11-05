# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = init_deck
  end

  def take_first_card
    card = @cards[0]
    @cards.delete(card)
    card
  end

  def init_deck
    deck = []
    Card::POSSIBLE_VALUES.each do |value|
      Card::POSSIBLE_SUITS.each do |suit|
        deck << Card.new(value, suit)
      end
    end
    deck.shuffle
  end
end
