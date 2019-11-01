# frozen_string_literal: true

require_relative 'card'


class Table
  attr_reader :deck, :players

  def initialize(player, dealer)
    @bank = 0
    @deck = init_deck
    @players = [player, dealer]
  end

  private

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


